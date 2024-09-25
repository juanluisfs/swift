//
//  FlashControlBundle.swift
//  FlashControl
//
//  Created by Juan Luis on 25/09/24.
//

import WidgetKit
import SwiftUI

@main
struct FlashControlBundle: WidgetBundle {
    var body: some Widget {
        FlashControl()
        FlashControlControl()
        WaterIntakeControl()
    }
}
