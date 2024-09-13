//
//  DeliveryStatus.swift
//  DynamicExample
//
//  Created by Juan Luis on 21/06/24.
//

import Foundation

enum DeliveryStatus: String, Codable {
    case pending = ""
    case sent = "Enviado"
    case inTransit = "En Reparto"
    case delivered = "Entregado"
}
