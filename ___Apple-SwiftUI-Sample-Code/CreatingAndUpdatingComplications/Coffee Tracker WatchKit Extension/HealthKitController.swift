/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A data controller that manages reading and writing data from the HealthKit store.
*/

import Foundation
import HealthKit
import os

class HealthKitController {
    
    let logger = Logger(subsystem: "com.example.apple-samplecode.Coffee-Tracker.watchkitapp.watchkitextension.HealthKitController",
                        category: "HealthKit")
    
    // MARK: - Properties
    
    // The key used to save and load anchor objects from user defaults.
    private let anchorKey = "anchorKey"
    
    // A weak link to the main model.
    private weak var model: CoffeeData?
    
    // The HealthKit store.
    private lazy var store = HKHealthStore()
    
    // Properties that determine whether the store is available and ready to use.
    private lazy var isAvailable = HKHealthStore.isHealthDataAvailable()
    private lazy var isAuthorized = false
    
    // Caffeine types, used to read and write caffeine samples.
    private lazy var caffeineType = HKObjectType.quantityType(forIdentifier: .dietaryCaffeine)!
    private lazy var types: Set<HKSampleType> = [caffeineType]
    
    // Milligram units.
    private lazy var miligrams = HKUnit.gramUnit(with: .milli)
    
    // An anchor object, used to download just the changes since the last time.
    private var anchor: HKQueryAnchor? {
        get {
            // If user defaults returns nil, just return it.
            guard let data = UserDefaults.standard.object(forKey: anchorKey) as? Data else {
                return nil
            }
            
            // Otherwise, unarchive and return the data object.
            do {
                return try NSKeyedUnarchiver.unarchivedObject(ofClass: HKQueryAnchor.self, from: data)
            } catch {
                // If an error occurs while unarchiving, log the error and return nil.
                logger.error("Unable to unarchive \(data): \(error.localizedDescription)")
                return nil
            }
        }
        set(newAnchor) {
            // If the new value is nil, save it.
            guard let newAnchor = newAnchor else {
                UserDefaults.standard.set(nil, forKey: anchorKey)
                return
            }
            
            // Otherwise convert the anchor object to Data, and save it in user defaults.
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: newAnchor, requiringSecureCoding: true)
                UserDefaults.standard.set(data, forKey: anchorKey)
            } catch {
                // If an error occurs while archiving the anchor, just log the error.
                // the value stored in user defaults is not changed.
                logger.error("Unable to archive \(newAnchor): \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Initializers
    
    // The HealthKit controller's initializer.
    init(withModel model: CoffeeData) {
        self.model = model
    }
    
    // MARK: - Public Methods
    
    // Request authorization to read and save the required data types.
    public func requestAuthorization(handler: @escaping (Bool) -> Void ) {
        guard isAvailable else { return }
        
        store.requestAuthorization(toShare: types, read: types) { [unowned self ](success, error) in
            
            // Check for any errors.
            guard error == nil else {
                logger.error("An error occurred while requesting HealthKit Authorization: \(error!.localizedDescription)")
                return
            }
            
            // Set the authorization property, and call the handler.
            self.isAuthorized = success
            handler(success)
        }
    }
    
    // Reads data from the HealthKit store.
    public func loadNewDataFromHealthKit( completionHandler: @escaping (Bool) -> Void = { _ in }) {
        
        guard isAvailable else {
            logger.debug("HealthKit is not available on this device.")
            completionHandler(false)
            return
        }
        
        logger.debug("Loading data from HealthKit")
        
        // Create a predicate that only returns samples created within the last 24 hours.
        let endDate = Date()
        let startDate = endDate.addingTimeInterval(-24.0 * 60.0 * 60.0)
        let datePredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [.strictStartDate, .strictEndDate])
        
        // Create the query.
        let query = HKAnchoredObjectQuery(
            type: caffeineType,
            predicate: datePredicate,
            anchor: anchor,
            limit: HKObjectQueryNoLimit) { [unowned self] (query, samples, deletedSamples, newAnchor, error) in
            
            // When the query ends, check for errors.
            if let error = error {
                logger.error("An error occurred while querying for samples: \(error.localizedDescription)")
                completionHandler(false)
                return
            }
            
            // Update the anchor.
            self.anchor = newAnchor
            
            // Convert new caffeine samples into Drink instances.
            var newDrinks = [Drink]()
            if let samples = samples {
                newDrinks = self.process(caffeineSamples: samples)
            }
            
            // Update the data on the main queue.
            DispatchQueue.main.async {
                
                // Create drink instances for any samples deleted from HealthKit.
                var deletedDrinks = [Drink]()
                if let deletedSamples = deletedSamples {
                    deletedDrinks = self.process(deletedCaffeineSamples: deletedSamples)
                }
                
                // Update the model.
                self.updateModel(newDrinks: newDrinks, deletedDrinks: deletedDrinks)
                completionHandler(true)
            }
        }
        
        store.execute(query)
    }
    
    // Save a drink to HealthKit as a caffeine sample.
    public func save(drink: Drink) {
        
        // Make sure HealthKit is available and authorized.
        guard isAvailable else { return }
        guard store.authorizationStatus(for: caffeineType) == .sharingAuthorized else { return }
        
        // Create metadata to hold the drink's UUID.
        // Use the sync identifier to remove drinks if they are deleted from
        // HealthKit.
        let metadata: [String: Any] = [HKMetadataKeySyncIdentifier: drink.uuid.uuidString,
                                       HKMetadataKeySyncVersion: 1]
        
        // Create a quantity object for the amount of caffeine in the drink.
        let mgCaffeine = HKQuantity(unit: miligrams, doubleValue: drink.mgCaffeine)
        
        // Create the caffeine sample.
        let caffeineSample = HKQuantitySample(type: caffeineType,
                                              quantity: mgCaffeine,
                                              start: drink.date,
                                              end: drink.date,
                                              metadata: metadata)
        
        // Save the sample to the HealthKit store.
        store.save(caffeineSample) { [unowned self] (success, error) in
            guard success else {
                self.logger.error("Unable to save \(caffeineSample) to the HealthKit store: \(error!.localizedDescription)")
                return
            }
            
            self.logger.debug("\(mgCaffeine) mg Drink saved to HealthKit")
        }
    }
    
    // MARK: - Private Methods
    // Take an array of caffeine samples and returns an array of drinks.
    private func process(caffeineSamples: [HKSample]) -> [Drink] {
        
        // Filter out any samples saved by this app.
        let newSamples = caffeineSamples.filter { (sample) -> Bool in
            sample.sourceRevision.source != HKSource.default()
        }
        
        logger.debug("\(newSamples.count) samples not from this app!")
        
        // Create an array to store the new drinks.
        var newDrinks = [Drink]()
        
        // Convert each sample into a drink, and add it to the array.
        for sample in newSamples {
            guard let sample = sample as? HKQuantitySample else { continue }
            let drink = Drink(mgCaffeine: sample.quantity.doubleValue(for: miligrams),
                              onDate: sample.startDate,
                              uuid: sample.uuid)
            
            newDrinks.append(drink)
        }
        
        // Return the array.
        return newDrinks
    }
    
    // For any drinks deleted from the HealthKit store, this also deletes them from the app's data.
    private func process(deletedCaffeineSamples: [HKDeletedObject]) -> [Drink] {
        assert(Thread.main == Thread.current, "Must be run on the main queue because it accesses currentDrinks.")
        
        // Get an array of drinks to delete.
        var drinksToDelete = [Drink]()
        
        // Find the UUID for each deleted drink. Use this to find the drink in the app's data.
        for deletedDrink in deletedCaffeineSamples {
            let uuidString = (deletedDrink.metadata?[HKMetadataKeySyncIdentifier] as? String)
            let uuid = UUID(uuidString: uuidString ?? "") ?? deletedDrink.uuid
            let uuids = model?.currentDrinks.map({ $0.uuid })
            guard let index = uuids?.firstIndex(of: uuid) else { continue }
            guard let drink = model?.currentDrinks[index] else { continue }
            drinksToDelete.append(drink)
        }
        
        logger.debug("\(drinksToDelete.count) drinks deleted from HealthKit.")
        
        return drinksToDelete
    }
    
    // Update the model.
    private func updateModel(newDrinks: [Drink], deletedDrinks: [Drink]) {
        assert(Thread.main == Thread.current, "Must be run on the main queue because it accesses currentDrinks.")
        
        // Get a copy of the current drink data.
        guard let oldDrinks = model?.currentDrinks else { return }
        
        // Remove the deleted drinks.
        var drinks = oldDrinks.filter { !deletedDrinks.contains($0) }
        
        // Add the new drinks.
        drinks.append(contentsOf: newDrinks)
        
        // Sort the array by date.
        drinks.sort { (lhs, rhs) -> Bool in
            lhs.date.compare(rhs.date) == .orderedAscending
        }
        
        model?.currentDrinks = drinks
    }
}
