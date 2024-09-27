//
//  WaterWidgetView.swift
//  create-with-swift-interactive-widget-tutorial-starting
//
//  Created by Matteo Altobello
//

import WidgetKit
import SwiftUI

struct WaterWidgetView: View {
    
    var entry: WaterTipProvider.Entry
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack{
                Image(systemName: "drop")
                Text("Tip of the day")
            }
            .font(.title3)
            .bold()
            .padding(.bottom, 8)
            
            Text(entry.waterTip)
                .font(.caption)
            
            Spacer()
            
            HStack{
                Spacer()
                Text("**Last Update:** \(entry.date.formatted(.dateTime))")
                    .font(.caption2)
                
            }
        }
        .foregroundStyle(.white)
        
        .containerBackground(for: .widget){
            Color.cyan
        }
    }
}
