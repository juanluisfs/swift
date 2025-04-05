//
//  BuildingATipJarApp.swift
//  BuildingATipJar
//
//  Created by Juan Luis Flores on 11/03/25.
//

import SwiftUI

@main
struct BuildingATipJarApp: App {
    
    @StateObject private var store = TipStore()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(store)
        }
    }
}
