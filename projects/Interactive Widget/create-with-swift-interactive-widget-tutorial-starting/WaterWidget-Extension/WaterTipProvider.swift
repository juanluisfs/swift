//
//  WaterProvider.swift
//  create-with-swift-interactive-widget-tutorial-starting
//
//  Created by Matteo Altobello
//

import Foundation
import WidgetKit

struct WaterTipProvider: TimelineProvider {
    
    private let waterTips = Tips()
    
    private let placeholderEntry = WaterEntry(
        date: Date(),
        waterTip: ""
    )
    
    func placeholder(in context: Context) -> WaterEntry {
        return placeholderEntry
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WaterEntry) -> ()) {
        completion(placeholderEntry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<WaterEntry>) -> Void) {
        let currentDate = Date()
        var entries : [WaterEntry] = []
        
        for minuteOffset in 0 ..< 60 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
            let tip = waterTips.tipsList[Int.random(in: 0...waterTips.tipsList.count-1)]
            let entry = WaterEntry(date: entryDate, waterTip: tip)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        
        completion(timeline)
    }
    
}
