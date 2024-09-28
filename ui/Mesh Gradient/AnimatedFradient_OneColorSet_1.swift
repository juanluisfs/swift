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
