//
//  DeliveryAttributes.swift
//  DynamicExample
//
//  Created by Juan Luis on 21/06/24.
//

import ActivityKit
import Foundation

struct DeliveryAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var deliveryStatus: DeliveryStatus
        var productName: String
        var estimatedArrivalDate: String
    }
}
