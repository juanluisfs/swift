//
//  WaterCupInteractiveWidget.swift
//  WaterCupInteractiveWidget
//
//  Created by Juan Luis on 27/09/24.
//

import WidgetKit
import SwiftUI

// 1. Create the Timeline Entry
struct WaterCupEntry: TimelineEntry {
    let date: Date
    var count: Int
}

// 2. Define the Timeline Provider
struct WaterCupProvider: TimelineProvider {
    
    func placeholder(in context: Context) -> WaterCupEntry {
        WaterCupEntry(date: Date(), count: WaterCupTracker.shared.currentCount())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WaterCupEntry) -> ()) {
        completion(WaterCupEntry(date: Date(), count: WaterCupTracker.shared.currentCount()))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let timeline = Timeline(entries: [WaterCupEntry(date: Date(), count: WaterCupTracker.shared.currentCount())], policy: .never)
        completion(timeline)
    }
}

struct WidgetsEntryView: View {
    @State var entry: WaterCupProvider.Entry
    
    var body: some View {
        VStack(spacing: 0) {
            CupCounterView(count: $entry.count, dimension: 70)
            
            HStack {
                Button(intent: DecrementCupIntent()) {
                    Image(systemName: "minus")
                        .fontWeight(.black)
                }
                .buttonStyle(.plain)
                .padding(16)
                .background(
                    Circle()
                        .foregroundStyle(.blue.opacity(0.1))
                )
                
                Button(intent: RestartCupIntent()) {
                    Image(systemName: "arrow.clockwise")
                        .fontWeight(.black)
                }
                .buttonStyle(.plain)
                .padding(10)
                .background(
                    Circle()
                        .foregroundStyle(.blue.opacity(0.1))
                )
                
                Button(intent: IncrementCupIntent()) {
                    Image(systemName: "plus")
                        .fontWeight(.black)
                }
                .buttonStyle(.plain)
                .padding(10)
                .background(
                    Circle()
                        .foregroundStyle(.blue.opacity(0.1))
                )
            }
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct WaterCupInteractiveWidget: Widget {
    let kind: String = "WaterTrackerExtension"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WaterCupProvider()) { entry in
            WidgetsEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall,.systemMedium])
        .configurationDisplayName("Water Tracker Widget")
        .description("Track your water consumption directly from the Home Screen")
    }
}

#Preview(as: .systemSmall) {
    WaterCupInteractiveWidget()
} timeline: {
    WaterCupEntry(date: .now, count: 1)
    WaterCupEntry(date: .now, count: 5)
}
