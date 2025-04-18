//
//  ContentView.swift
//  AppWatchConnectivity
//
//  Created by Juan Luis Flores on 17/04/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var connectivity = Connectivity()
    
    var body: some View {
        VStack {
            Text(connectivity.receivedText)
            Button("Message", action: sendMessage)
        }
        .padding()
    }
    
    func sendMessage() {
        let data = ["text":"Hello from the phone"]
        connectivity.sendMessage(data)
    }
}


#Preview {
    ContentView()
}
