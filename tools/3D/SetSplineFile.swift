// Video: https://www.youtube.com/watch?v=kYL0Ef3XKO0&list=WL&index=6
// Get Spline Package: https://github.com/splinetool/spline-ios

import SwiftUI
import SplineRuntime

struct ContentView: View {
    var body: some View {
        VStack {
            Onboard3DView()
                .frame(height: 500)
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                Text("Build your brand")
                    .font(.title.bold())
                
                Text("Stay up to date with all your social media platforms in one simple app.")
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal)
            
            Spacer()
            
            Button("Get Started") {
                // Button action
            }
            .buttonStyle(.borderedProminent)
            .tint(.pink)
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}

struct Onboard3DView: View {
    var body: some View {
        // fetching from cloud
        let url = URL(string: "https://build.spline.design/YU8leEOyHuePfSKaJv9d/scene.splineswift")!

        // fetching from local
        // let url = Bundle.main.url(forResource: "scene", withExtension: "splineswift")!

        SplineView(sceneFileURL: url).ignoresSafeArea(.all)
    }
}
