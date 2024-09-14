import SwiftUI

struct TapToExpand: View {
    
    @State var isExpanded = false
    @Namespace var animation
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
            VStack {
                Text(isExpanded ? "Amazing Content" : "Tap to Expand")
                    .font(.system(size: isExpanded ? 28 : 20, weight: .bold, design: .rounded))
                    .matchedGeometryEffect(id: "title", in: animation)
                if isExpanded {
                    Text("Discover more here!")
                        .transition(.opacity)
                }
            }
            .foregroundStyle(.white)
        }
        .frame(height: isExpanded ? 200 : 80)
        .padding()
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: isExpanded)
        .onTapGesture {
            isExpanded.toggle()
        }
    }
}

#Preview {
    TapToExpand()
}
