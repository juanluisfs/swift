//
//  ContentView.swift
//  PopUp_CopiedToClipboard
//
//  Created by Juan Luis on 05/08/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var copied = false
    
    var body: some View {
        ZStack {
            LabeledContent {
                Text("Uusario 1")
            } label: {
                Text("User ID")
            }
            
            if copied {
                Text("Copied to Clipboard")
                    .font(.system(.body, design: .rounded, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.orange.cornerRadius(30))
                    .padding(.bottom)
                    .shadow(radius: 5)
                    .transition(.move(edge: .bottom))
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .onTapGesture {
            withAnimation(.snappy) {
                copied = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.snappy) {
                    copied = false
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
