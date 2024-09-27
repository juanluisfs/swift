//
//  IncrementCupIntent.swift
//  create-with-swift-interactive-widget-tutorial-starting
//
//  Created by Juan Luis on 27/09/24.
//

import AppIntents

// 2.
struct IncrementCupIntent: AppIntent {
    // 3.
    static var title: LocalizedStringResource = "Add a cup of water"
    static var description = IntentDescription("Increment the number of cup of water")
    
    // 4.
    func perform() async throws -> some IntentResult {
        WaterCupTracker.shared.incrementCount()
        return .result()
    }
}

struct DecrementCupIntent: AppIntent {
    // 3.
    static var title: LocalizedStringResource = "Remove a cup of water"
    static var description = IntentDescription("Decrement the number of cup of water")
    
    // 4.
    func perform() async throws -> some IntentResult {
        WaterCupTracker.shared.decrementCount()
        return .result()
    }
}

struct RestartCupIntent: AppIntent {
    // 3.
    static var title: LocalizedStringResource = "Restart count"
    static var description = IntentDescription("Restart the number of cup of water")
    
    // 4.
    func perform() async throws -> some IntentResult {
        WaterCupTracker.shared.resetCount()
        return .result()
    }
}
