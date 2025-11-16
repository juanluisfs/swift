// Source - https://stackoverflow.com/a
// Posted by Mojtaba Hosseini, modified by community. See post 'Timeline' for change history
// Retrieved 2025-11-16, License - CC BY-SA 4.0

struct LinearProgressView<Shape: SwiftUI.Shape>: View {
    var value: Double
    var shape: Shape

    var body: some View {
        shape.fill(.foreground.quaternary)
             .overlay(alignment: .leading) {
                 GeometryReader { proxy in
                     shape.fill(.tint)
                          .frame(width: proxy.size.width * value)
                 }
             }
             .clipShape(shape)
    }
}
