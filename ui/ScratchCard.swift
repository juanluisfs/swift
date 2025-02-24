//
//  ContentView.swift
//  Pruebas
//
//  Created by Juan Luis on 23/02/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var scratchPoints: [CGPoint] = []
    let brushSize: CGFloat = 30
    let overlayColor: Color = .gray
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("Congratu;ations")
            }
            .frame(width: 300, height: 200)
            .background(Color.yellow)
            .clipShape(.rect(cornerRadius: 12))
            .shadow(radius: 10)
            
            Canvas { context, size in
                context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(overlayColor))
                
                context.blendMode = .destinationOut
                
                for point in scratchPoints {
                    let rect = CGRect(x: point.x - brushSize, y: point.y - brushSize / 2, width: brushSize, height: brushSize)
                    context.fill(Path(ellipseIn: rect), with: .color(.black))
                }
                
                context.blendMode = .normal
            }
            .frame(width: 300, height: 200)
            .clipShape(.rect(cornerRadius: 12))
            .animation(.linear, value: scratchPoints)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        let currenPoint = value.location
                        scratchPoints.append(currenPoint)
                    })
            )
        }
    }
}

#Preview {
    ContentView()
}
