import SwiftUI

struct ContentView: View {
    
    @State private var isCaptured = false
    
    private let screenshotPublisher = NotificationCenter.default.publisher(
        for: UIApplication.userDidTakeScreenshotNotification
    )
    
    var body: some View {
        Text(isCaptured ? "Captured" : "Take a screenshot")
            .foregroundStyle(isCaptured ? .red : .primary)
            .font(.system(size: 70))
            .onReceive(screenshotPublisher) { _ in
                isCaptured = true
            }
    }
}
