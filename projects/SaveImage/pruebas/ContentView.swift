import SwiftUI

struct RenderView: View {
    
    let text: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 200, height: 200)
                .foregroundStyle(.mint)
            
            Text(text)
                .font(.largeTitle)
                .foregroundStyle(.white)
                .padding()
                .background(.blue)
                .clipShape(Capsule())
        }
    }
}

struct ContentView: View {
    
    @State private var text = "Your text here"
    @State private var renderedImage = Image(systemName: "photo")
    @Environment(\.displayScale) var displayScale
    
    var body: some View {
        VStack {
            renderedImage
            
            ShareLink("Export", item: renderedImage, preview: SharePreview(Text("Shared image"), image: renderedImage))
            
            TextField("Enter some text", text: $text)
                .textFieldStyle(.roundedBorder)
                .padding()
        }
        .onChange(of: text, {
            render()
        })
        .onAppear { render() }
    }
    
    @MainActor func render() {
        let renderer = ImageRenderer(content: RenderView(text: text))
        renderer.scale = displayScale
        
        if let uiImage = renderer.uiImage {
            renderedImage = Image(uiImage: uiImage)
        }
    }
    
}
