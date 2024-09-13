//
//  DeliveryActivityUseCase.swift
//  DynamicExample
//
//  Created by Juan Luis on 21/06/24.
//

import ActivityKit
import Foundation

final class DeliveryActivityUseCase {
    static func startActivity(deliveryStatus: DeliveryStatus,
                              productName: String,
                              estimatedArrivalDate: String) throws -> String {
        // Verificar si las actividades están habilitadas
        guard ActivityAuthorizationInfo().areActivitiesEnabled else { return "" }
        
        // Crear el estado inicial
        let initialState = DeliveryAttributes.ContentState(deliveryStatus: deliveryStatus,
                                                           productName: productName,
                                                           estimatedArrivalDate: estimatedArrivalDate)
        
        // Calcular la fecha futura
        let futureDate = Date().addingTimeInterval(3600) // Agregar 3600 segundos (1 hora)
        
        // Crear el contenido de la actividad
        let activityContent = ActivityContent(state: initialState,
                                              staleDate: futureDate)
        
        // Crear los atributos de la entrega
        let attributes = DeliveryAttributes()
        
        // Solicitar la actividad y manejar posibles errores
        do {
            let activity = try Activity.request(attributes: attributes, content: activityContent)
            return activity.id
        } catch {
            throw error
        }
    }
    
    static func updateActivity(activityIdentifier: String,
                               newDeliveryStatus: DeliveryStatus,
                               productName: String,
                               estimatedArrivalDate: String) async {
        let updateContentSatet = DeliveryAttributes.ContentState(deliveryStatus: newDeliveryStatus,
                                                                 productName: productName,
                                                                 estimatedArrivalDate: estimatedArrivalDate)
        
        let activity = Activity<DeliveryAttributes>.activities.first(where: { $0.id == activityIdentifier })
        let activityContent = ActivityContent(state: updateContentSatet, staleDate: .now + 36000)
        
        await activity?.update(activityContent)
    }
    
    static func endActivity(withActivityIdentifier activityIdentifier: String) async {
        let value = Activity<DeliveryAttributes>.activities.first(where: { $0.id == activityIdentifier })
        await value?.end(nil)
    } 
}


