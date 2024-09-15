//
//  DataItem.swift
//  SwiftDataDemo
//
//  Created by Juan Luis on 10/05/24.
//

import Foundation
import SwiftData

@Model
class DataItem: Identifiable {
    
    var id: String
    var name: String
    
//    @Attribute(.externalStorage)
    var image: Data?
    
    init(name: String) {
        self.id = UUID().uuidString
        self.name = name
    }
}
