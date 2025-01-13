import SwiftUI

struct Rotation: View {
    
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
        }
    }
}

#Preview {
    Rotation()
}
