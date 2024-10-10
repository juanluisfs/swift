//
//  AnimatedMeshView.swift
//  MeshGradientAnimatedExample
//
//  Created by Juan Luis on 25/09/24.
//
import SwiftUI

struct AnimatedMeshView: View {
    @State var t: Float = 0.0
    @State var timer: Timer?

    var body: some View {
        MeshGradient(width: 3, height: 3, points: [
            .init(0, 0), .init(0.5, 0), .init(1, 0),
            [point(-0.8...(-0.2), timeScale: 0.342), point(0.3...0.7, timeScale: 0.984)],
            [point(0.1...0.8, timeScale: 0.084), point(0.2...0.8, timeScale: 0.242)],
            [point(1.4...1.5, timeScale: 0.084), point(0.4...0.8, timeScale: 0.642)],
            [point(-0.8...(-0.2), timeScale: 0.442), point(1.4...1.9, timeScale: 0.984)],
            [point(0.3...0.6, timeScale: 0.784), point(1.2...1.4, timeScale: 0.772)],
            [point(1.2...1.5, timeScale: 0.056), point(1.3...1.7, timeScale: 0.342)]
        ], colors: [
            .teal, .purple, .indigo,
            .orange, .pink, .blue,
            .blue, .yellow, .mint
        ])
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
                t += 0.04
            }
        }
        .animation(.bouncy, value: t)
        .background(.black)
        .ignoresSafeArea()
    }

    func point(_ range: ClosedRange<Float>, timeScale: Float) -> Float {
        let amplitude = (range.upperBound - range.lowerBound) / 2
        let midPoint = (range.upperBound + range.lowerBound) / 2
        let value = midPoint + (amplitude * sin(timeScale * t))
        return value
    }
}

#Preview {
    AnimatedMeshView()
}

/*
 struct AnimatedMeshView: View {
     @State var t: Float = 0.0
     @State var timer: Timer?

     var body: some View {
         MeshGradient(width: 3, height: 3, points: [
             [sinInRange(-0.8...(-0.2), offset: 0.439, timeScale: 0.342, t: t),
              sinInRange(0.3...0.7, offset: 3.42, timeScale: 0.984, t: t)],
             [sinInRange(0.1...0.8, offset: 0.239, timeScale: 0.084, t: t),
              sinInRange(0.2...0.8, offset: 5.21, timeScale: 0.242, t: t)],
             [sinInRange(1.0...1.5, offset: 0.939, timeScale: 0.084, t: t),
              sinInRange(0.4...0.8, offset: 0.25, timeScale: 0.642, t: t)],
             [sinInRange(-0.8...(-0.2), offset: 0.439, timeScale: 0.342, t: t),
              sinInRange(0.3...0.7, offset: 3.42, timeScale: 0.984, t: t)],
             [sinInRange(0.1...0.8, offset: 0.239, timeScale: 0.084, t: t),
              sinInRange(0.2...0.8, offset: 5.21, timeScale: 0.242, t: t)],
             [sinInRange(1.0...1.5, offset: 0.939, timeScale: 0.084, t: t),
              sinInRange(0.4...0.8, offset: 0.25, timeScale: 0.642, t: t)],
             [sinInRange(-0.8...0.0, offset: 1.439, timeScale: 0.442, t: t),
              sinInRange(1.4...1.9, offset: 3.42, timeScale: 0.984, t: t)],
             [sinInRange(0.3...0.6, offset: 0.339, timeScale: 0.784, t: t),
              sinInRange(1.0...1.2, offset: 1.22, timeScale: 0.772, t: t)],
             [sinInRange(1.0...1.5, offset: 0.939, timeScale: 0.056, t: t),
              sinInRange(1.3...1.7, offset: 0.47, timeScale: 0.342, t: t)]
         ], colors: [
             .red, .purple, .indigo,
             .orange, .pink, .blue,
             .blue, .yellow, .mint
         ])
         .onAppear {
             timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
                 t += 0.02
             }
         }
         .background(.black)
         .ignoresSafeArea()
     }

     func sinInRange(_ range: ClosedRange<Float>, offset: Float, timeScale: Float, t: Float) -> Float {
         let amplitude = (range.upperBound - range.lowerBound) / 2
         let midPoint = (range.upperBound + range.lowerBound) / 2
         return midPoint + amplitude * sin(timeScale * t + offset)
     }
 }

 #Preview {
     AnimatedMeshView()
 }

 */
