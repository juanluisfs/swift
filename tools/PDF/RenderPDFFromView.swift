import SwiftUI

@MainActor
struct ContentView: View {
    var body: some View {
        ShareLink("Export PDF", item: render())
    }
    
    func render() -> URL {
        let render = ImageRenderer(content:
            Text("Hello, World!")
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(Capsule())
        )
        
        let url = URL.documentsDirectory.appending(path: "output.pdf")
        
        render.render { size, context in
            var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            
            guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
                return
            }
            
            pdf.beginPDFPage(nil)
            
            context(pdf)
            
            pdf.endPDFPage()
            pdf.closePDF()
        }
        
        return url
    }
}

#Preview {
    ContentView()
}
