//
//  ContentView.swift
//  GlowingButton
//
//  Created by Juan Luis on 05/08/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var state: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.black)
                .ignoresSafeArea()
            
            GlowingButton(text: "Hello, world!") {
                state.toggle()
            }
        }
    }
}

struct GlowingButton: View {
    
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 25, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 240, height: 56)
                .background(
                    Capsule()
                        .stroke(Color.red, lineWidth: 2)
                        .shadow(
                            color: Color.orange,
                            radius: 4,
                            y: 0
                        )
                )
                .shadow(
                    color: Color.orange,
                    radius: 6,
                    x: 0,
                    y: 0
                )
                .padding(25)
        }
    }
}

#Preview {
    ContentView()
}
