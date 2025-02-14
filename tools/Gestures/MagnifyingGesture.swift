import SwiftUI

struct PersonView: View {
    
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        Image(.person)
            .resizable()
            .scaledToFit()
            .scaleEffect(scale)
            .gesture(
                MagnifyGesture()
                    .onChanged {
                        scale = $0.magnification
                    }
            )
    }
}

#Preview {
    PersonView()
}
