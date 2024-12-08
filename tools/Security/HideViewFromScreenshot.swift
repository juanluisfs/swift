import SwiftUI

struct PreventView<Content: View>: View {
    
    var content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    // MARK: - UI
    @State private var hostingController: UIHostingController<Content>?
    
    var body: some View {
        _ScreenshotPreventHelper(hostingController: $hostingController)
            .overlay(
                GeometryReader {
                    let size = $0.size
                    
                    Color.clear
                        .preference(key: SizeKey.self, value: size)
                        .onPreferenceChange(SizeKey.self, perform: { value in
                            if value != .zero {
                                /// Create Hosting Controller with Size
                                if hostingController == nil {
                                    hostingController = UIHostingController(rootView: content)
                                    hostingController?.view.backgroundColor = .clear
                                    hostingController?.view.tag = 1009
                                    hostingController?.view.frame = .init(origin: .zero, size: size)
                                } else {
                                    /// Sometimes the view size may update. In that case we update the UIView Size
                                    hostingController?.view.frame = .init(origin: .zero, size: size)
                                }
                            }
                        })
                }
            )
    }
    
}
