import SwiftUI
import CoreMotion

class MotionManager: ObservableObject {
    private var motionManager: CMMotionManager = CMMotionManager()
    @Published var roll: Double = 0.0
    @Published var pitch: Double = 0.0
    @Published var yaw: Double = 0.0

    init() {
        startMotionUpdates()
    }

    func startMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1.0 / 120.0 // 60 Hz
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
                guard let motion = motion, error == nil else { return }
                self?.roll = motion.attitude.roll * 40 / .pi // Convert to degrees
                self?.pitch = (motion.attitude.pitch * 90 / .pi) - 40
                self?.yaw = motion.attitude.yaw * 30 / .pi
            }
        }
    }

    func stopMotionUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }
}

struct Rotation: View {
    
    @StateObject private var motionManager = MotionManager()
    
    @State private var flipped: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                if !flipped {
                    Text("What is the meaning of 'Appreciation'")
                } else {
                    Text("thank, thanks, appreciation, gratitude, auditor, inspection")
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 0.0, y: 1.0, z: 0.0))
                }
            }
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: 300, maxHeight: 600)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
            .rotation3DEffect(
                flipped ? Angle(degrees: 180) : .zero,
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .animation(.bouncy, value: flipped)
            .onTapGesture {
                flipped.toggle()
            }
            .rotation3DEffect(
                .degrees(motionManager.pitch),
                axis: (x: 1, y: 0, z: 0)
            )
            .rotation3DEffect(
                .degrees(motionManager.yaw),
                axis: (x: 0, y: 0, z: 1)
            )
            .onAppear {
                motionManager.startMotionUpdates()
            }
            .onDisappear {
                motionManager.stopMotionUpdates()
            }
            .animation(.snappy, value: motionManager.pitch)
            
            Text("\(motionManager.pitch)")
        }
    }
}

#Preview {
    Rotation()
}
