//
//  MyExtensionLiveActivity.swift
//  MyExtension
//
//  Created by Juan Luis on 21/06/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

@main
struct MyExtensionLiveActivity: Widget {
    
    
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DeliveryAttributes.self) { context in
            // Lock screen/banner UI goes here
            
            HStack {
                Image(systemName: "box.truck.badge.clock.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.indigo)
                    .padding(.leading, 12)
                VStack(alignment: .leading) {
                    Text(context.state.productName).bold()
                    + Text(" está ")
                    + Text(context.state.deliveryStatus.rawValue).bold()
                }
                Spacer()
                VStack(alignment: .center) {
                    Text("Hora de entrega")
                    Text(context.state.estimatedArrivalDate).bold()
                }
                .padding(.trailing, 12)
            }

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Image(systemName: "box.truck.badge.clock.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(.leading, 12)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.productName)
                        .bold()
                        .multilineTextAlignment(.center)
                }
                DynamicIslandExpandedRegion(.center) {
                    Text("Paquete: \(context.state.deliveryStatus.rawValue)")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    
                    Button {
                        
                    } label: {
                        Label("Cancelar Pedido", systemImage: "xmark.circle.fill")
                    }
                    
                    /*
                    VStack {
                        Text("Step up in this bitch like")
                        Text("She wanna see it it'll fit her right")
                        Text("Waves don't die, baby")
                        Text("Sun don't shine in the shade")
                        Text("Step up in this bitch like")
                        Text("She wanna see it it'll fit her right")
                        Text("Waves don't die, baby")
                        Text("Sun don't shine in the shade")
                    }
                     */
                }
            } compactLeading: {
                HStack {
                    Image(systemName: "box.truck.badge.clock.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text(context.state.productName)
                }
            } compactTrailing: {
                Text(context.state.deliveryStatus.rawValue)
            } minimal: {
                /*
                Image(systemName: "box.truck.badge.clock.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.green)
                 */
                
                Image("noname")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 35)
            }
            .keylineTint(.blue)
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

struct MyExtensionLiveActivity_Previews: PreviewProvider {
    static let attributes = DeliveryAttributes()
    static let contentState = DeliveryAttributes.ContentState(deliveryStatus: .sent,
                                                              productName: "Camiseta $400",
                                                              estimatedArrivalDate: "21:00")
    static var previews: some View {
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.compact))
            .previewDisplayName("Island Compact")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Island Expandend")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.minimal))
            .previewDisplayName("Minimal")
        attributes
            .previewContext(contentState, viewKind: .content)
            .previewDisplayName("Notification")
    }
}
