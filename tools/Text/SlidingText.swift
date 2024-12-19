import SwiftUI

struct DemoSlideText: View {
    
    let text = "Lorem ipsum dolor sit amet, consetetur sadipsing elitr, sed diam nonumy eirmod tempor"
    
    @State private var go = false
    
    var body: some View {
        VStack {
            Text(text)
        }
        .fixedSize()
        .frame(width: 50, alignment: go ? .trailing:.leading)
        .clipped()
        .onAppear {
            self.go.toggle()
        }
        .animation(.linear(duration: 20).repeatForever(autoreverses: true), value: go)
    }
}

#Preview {
    DemoSlideText()
}
