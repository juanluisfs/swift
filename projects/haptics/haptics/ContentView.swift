//
//  ContentView.swift
//  haptics
//
//  Created by Juan Luis on 04/08/22.
//

import SwiftUI

struct ContentView: View {
    
    let generator = UINotificationFeedbackGenerator()
    
    var body: some View {
        VStack(alignment: .center, spacing: 30.0){
            Button(action: {
                self.generator.notificationOccurred(.success)
            }){
                Text("Success")
            }
            
            Button(action: {
                self.generator.notificationOccurred(.error)
            }){
                Text("Error")
            }
            
            Button(action: {
                self.generator.notificationOccurred(.warning)
            }){
                Text("Warning")
            }
            
            Button(action:{
                let impactLight = UIImpactFeedbackGenerator(style: .light)
                impactLight.impactOccurred()
            }){
                Text("Light")
            }
            
            Button(action:{
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }){
                Text("Medium")
            }
            
            Button(action:{
                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                impactHeavy.impactOccurred()
            }){
                Text("Heavy")
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
