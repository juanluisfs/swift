import SwiftUI
import WidgetKit

class WaterCupTracker {
    
    static let shared: WaterCupTracker = WaterCupTracker()
    
    private let sharedDefaults: UserDefaults
    
    private init() {
        sharedDefaults = UserDefaults(suiteName: "group.jlfs.watercup.shared")!
    }
    
    func incrementCount() {
        var count = sharedDefaults.integer(forKey: "count")
        count += 1
        sharedDefaults.set(count, forKey: "count")
        
        WidgetCenter.shared.reloadTimelines(ofKind: "WaterTrackerExtension")
    }
    
    func decrementCount() {
        var count = sharedDefaults.integer(forKey: "count")
        if count > 0 {
            count -= 1
        }
        sharedDefaults.set(count, forKey: "count")
        
        WidgetCenter.shared.reloadTimelines(ofKind: "WaterTrackerExtension")
    }
    
    func currentCount() -> Int {
        sharedDefaults.integer(forKey: "count")
    }
    
    func resetCount() {
        sharedDefaults.set(0, forKey: "count")
        
        WidgetCenter.shared.reloadTimelines(ofKind: "WaterTrackerExtension")
    }
}
