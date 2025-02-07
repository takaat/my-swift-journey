//
//  CityExplorerApp.swift
//  CityExplorer
//
//  Created by Luan Nguyen on 03/01/2021.
//

import SwiftUI

@main
struct CityExplorerApp: App {
    // MARK: - PROPERTIES
    @StateObject var locationManager = LocationManager()
    
    // MARK: - BODY
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(locationManager)
        }
    }
}
