//
//  WaterTips_Widget_Extension.swift
//  create-with-swift-interactive-widget-tutorial-starting
//
//  Created by Matteo Altobello
//

import WidgetKit
import SwiftUI

@main
struct WaterTips_Widget_Extension: Widget {
    
    let kind: String = "create-with-swift-tips-widget"
    
    var body: some WidgetConfiguration {
        
        StaticConfiguration(
            kind: kind,
            provider: WaterTipProvider(),
            content: { WaterWidgetView(entry: $0) }
        )
        
        .configurationDisplayName("Water tips")
        
        .description("Some little tips about water that will change your life!")
        
        .supportedFamilies([
            .systemMedium,
            .systemLarge
        ])
    }
}
