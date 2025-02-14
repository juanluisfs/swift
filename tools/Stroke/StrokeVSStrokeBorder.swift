import SwiftUI

struct StrokeView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Basic Rectangle
            Rectangle()
                .fill(.black)
                .frame(width: 350, height: 250)
            
            // Stroke Border makes the stroke only inside the frame
            Rectangle()
                .fill(.black)
                .strokeBorder(.orange, lineWidth: 40)
                .frame(width: 350, height: 250)
            
            // Stroke border makes half stroke inside and half stroke outside
            Rectangle()
                .fill(.black)
                .stroke(.orange, lineWidth: 40)
                .frame(width: 350, height: 250)
        }
    }
}

#Preview {
    StrokeView()
}
