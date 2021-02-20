/*
 See LICENSE folder for this sample’s licensing information.

 Abstract:
 The model for an individual landmark.
 */

import CoreLocation
import SwiftUI

struct Landmark: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    fileprivate var imageName: String
    fileprivate var coordinates: Coordinates
    var state: String
    var park: String
    var category: Category
    var isFavorite: Bool
    var isFeatured: Bool

    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: self.coordinates.latitude,
            longitude: self.coordinates.longitude
        )
    }

    var featureImage: Image? {
        guard self.isFeatured else { return nil }

        return Image(
            ImageStore.loadImage(name: "\(self.imageName)_feature"),
            scale: 2,
            label: Text(self.name)
        )
    }

    enum Category: String, CaseIterable, Codable, Hashable {
        case featured = "Featured"
        case lakes = "Lakes"
        case rivers = "Rivers"
        case mountains = "Mountains"
    }
}

extension Landmark {
    var image: Image {
        ImageStore.shared.image(name: self.imageName)
    }
}

struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}
