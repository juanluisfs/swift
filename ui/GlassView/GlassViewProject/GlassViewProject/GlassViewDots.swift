//
//  GlassViewDots.swift
//  GlassViewProject
//
//  Created by Juan Luis on 21/08/24.
//

import SwiftUI

struct GlassViewDots: View {
    var body: some View {
        ZStack {
            Color.gray
                .opacity(0.25)
                .ignoresSafeArea()
            
            Color.white
                .opacity(0.7)
                .blur(radius: 200)
                .ignoresSafeArea()
            
            GeometryReader { geometry in
                let size = geometry.size
                Circle()
                    .fill(.purple)
                    .padding(50)
                    .blur(radius: 60)
                    .offset(
                        x: -size.width/1.8,
                        y: -size.height/5
                    )
                
                Circle()
                    .fill(.blue)
                    .padding(50)
                    .blur(radius: 75)
                    .offset(
                        x: size.width/1.8,
                        y: size.height/2
                    )
            }
            
            /*
            RoundedRectangle(cornerRadius: 20.0)
                .fill(.white)
                .opacity(0.25)
                .shadow(radius: 10.0)
                .padding()
             */
            
            Text("Hello, World!")
                .padding()
                .glass(cornerRadius: 20.0)
        }
    }
}

#Preview {
    GlassViewDots()
}
