//
//  SwiftDataDemoApp.swift
//  SwiftDataDemo
//
//  Created by Juan Luis on 10/05/24.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: DataItem.self)
    }
}
