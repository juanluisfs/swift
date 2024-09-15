//
//  ContentView.swift
//  GlassViewProject
//
//  Created by Juan Luis on 21/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.purple
                .ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 20.0)
                .fill(.white)
                .opacity(0.25)
                .shadow(radius: 10.0)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
