import CoreHaptics
import SwiftUI

struct ContentView: View {
    
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Button("Play Haptic", action: complexSuccess)
            .onAppear(perform: prepareHaptics)
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
        do {
            let path = Bundle.main.path(forResource: "haptic1", ofType: "ahap")!
            try engine?.playPattern(from: URL(fileURLWithPath: path))
            try engine?.start()
        } catch {
            print("Failed")
        }
    }
}

#Preview {
    ContentView()
}
