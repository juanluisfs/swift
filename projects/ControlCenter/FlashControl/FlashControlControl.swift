//
//  FlashControlControl.swift
//  FlashControl
//
//  Created by Juan Luis on 25/09/24.
//

import AppIntents
import SwiftUI
import WidgetKit

struct FlashControlControl: ControlWidget {
    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(
            kind: "com.jlfs.ExploreControlCenter.FlashControl"
        ) {
            ControlWidgetToggle(
                "Turn \(ControlManager.shared.isRunning ? "Off" : "On") flashlight",
                isOn: ControlManager.self.shared.isRunning,
                action: FlashControlIntent()
            ) { isRunning in
                Label(isRunning ? "On" : "Off", systemImage: isRunning ? "flashlight.on.fill":"flashlight.off.fill")
            }
            .tint(.red)
        }
        .displayName("Flashlight")
        .description("A an example control that turns on and off the flashlight.")
    }
}

struct WaterIntakeControl: ControlWidget {
    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration (
            kind: "com.jlfs.ExploreControlCenter.WaterIntake"
        ) {
            ControlWidgetButton(action: WaterIntakeIntent(count: 1)) {
                Text("You had \(ControlManager.shared.glassesOfWater) glasses of water")
                Image(systemName: "wineglass.fill")
                    .tint(.blue)
            }
        }
    }
}


/*
extension FlashControlControl {
    struct Provider: ControlValueProvider {
        var previewValue: Bool {
            false
        }

        func currentValue() async throws -> Bool {
            let isRunning = true // Check if the timer is running
            return isRunning
        }
    }
}
*/

struct FlashControlIntent: SetValueIntent {
    static let title: LocalizedStringResource = "Start flashlight"

    @Parameter(title: "Flashlight is On")
    var value: Bool

    func perform() async throws -> some IntentResult {
        // Start / stop the timer based on `value`.
        ControlManager.shared.isRunning.toggle()
        return .result()
    }
}

struct WaterIntakeIntent: AppIntent {
    static var title: LocalizedStringResource = "Record Water Intake"
    
    @Parameter(title: "Water Intake")
    var count: Int
    
    init() {}
    
    init(count: Int) {
        self.count = count
    }
    
    func perform() async throws -> some IntentResult {
        ControlManager.shared.glassesOfWater += count
        return .result()
    }
}
