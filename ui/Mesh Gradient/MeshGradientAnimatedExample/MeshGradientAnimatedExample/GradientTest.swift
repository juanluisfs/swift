//
//  GradientTest.swift
//  MeshGradientAnimatedExample
//
//  Created by Juan Luis on 25/09/24.
//

import SwiftUI

struct GradientTest: View {
    
    @State private var isAnimating = false
    
    @State var colors1 = (0..<9).map { _ in [Color.green, .blue, .cyan, .teal].randomElement()!}
    @State var colors2 = (0..<9).map { _ in [Color.green, .blue, .cyan, .teal].randomElement()!}
    
    var body: some View {
        MeshGradient(
            width: 3,
            height: 3,
            points: [
                .init(x: 0, y:0), .init(x: 0.5, y:0), .init(x: 1, y:0),
                .init(x: 0, y:0.5), .init(x: 0.5, y:0.5), .init(x: 1, y:0.5),
                .init(x: 0, y:1), .init(x: 0.5, y:1), .init(x: 1, y:1)
            ],
            colors: isAnimating ? colors1 : colors2
        )
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeIn(duration: 5).repeatForever()) {
                isAnimating.toggle()
            }
        }
    }
}

#Preview {
    GradientTest()
}
