//
//  ContentView.swift
//  DynamicExample
//
//  Created by Juan Luis on 21/06/24.
//

import SwiftUI

struct ContentView: View {

    @State var productName: String = "Camiseta $400"
    @State var currentDeliveryState: DeliveryStatus = .pending
    @State var activityIdentifier: String = ""
    
    var body: some View {
        VStack {
            Text("Prueba de Dynamic Island")
                .font(.system(size: 28, weight: .bold))
                .padding(.bottom, 32)
            
            AsyncImage(url: .init(string: "https://productimage.zegna.com/is/image/zegna/UDC95A7-C32-B07-F?wid=1194&hei=1592")) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            } placeholder: {
                ProgressView()
            }
            
            Text(productName)
                .font(.system(.largeTitle))
            
            Text(currentDeliveryState.rawValue)
                .font(.system(.body))
            
            Button("Comprar", systemImage: "cart.fill") {
                buyProduct()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 18)
            
            Button("Actualizar", systemImage: "arrow.clockwise.circle.fill") {
                changeState()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 18)
            
            Button("Eliminar", systemImage: "trash.fill") {
                removeState()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 18)
        }
        .padding()
    }
    
    func buyProduct() {
        currentDeliveryState = .sent
        do {
            activityIdentifier = try DeliveryActivityUseCase.startActivity(deliveryStatus: currentDeliveryState, productName: productName, estimatedArrivalDate: "21:00")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func changeState() {
        currentDeliveryState = .inTransit
        
        Task {
            await DeliveryActivityUseCase.updateActivity(activityIdentifier: activityIdentifier, newDeliveryStatus: currentDeliveryState, productName: productName, estimatedArrivalDate: "21:00")
        }
    }
    
    func removeState() {
        Task {
            await DeliveryActivityUseCase.endActivity(withActivityIdentifier: activityIdentifier)
        }
    }
}

#Preview {
    ContentView()
}
