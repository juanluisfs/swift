import SwiftUI

// Main App Code
@main
struct OrientationControlApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    // If you want to begin with portrait mode, set this to portrait
    static var orientation: UIInterfaceOrientationMask = .all
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return Self.orientation
    }
}

// Content View Code
enum Orientation: String, CaseIterable {
    case all = "All"
    case portrait = "Portrait"
    case landscapeLeft = "Left"
    case landscapeRight = "Right"
    
    var mask: UIInterfaceOrientationMask {
        switch self {
        case .all: return .all
        case .portrait: return .portrait
        case .landscapeLeft: return .landscapeLeft
        case .landscapeRight: return .landscapeRight
        }
    }
}

struct ContentView: View {
    
    @State private var orientation: Orientation = .portrait
    
    var body: some View {
        NavigationStack {
            List {
                Section("Orientation") {
                    Picker("", selection: $orientation) {
                        ForEach(Orientation.allCases, id: \.rawValue) { orientation in
                            Text(orientation.rawValue)
                                .tag(orientation)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: orientation, initial: true) { oldValue, newValue in
                        modifyOrientation(newValue.mask)
                    }
                }
            }
        }
    }
}

extension View {
    func modifyOrientation(_ mask: UIInterfaceOrientationMask) {
        if let windowScene = (UIApplication.shared.connectedScenes.first as? UIWindowScene) {
            AppDelegate.orientation = mask
            windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: mask))
            windowScene.keyWindow?.rootViewController?.setNeedsUpdateOfSupportedInterfaceOrientations()
        }
    }
}

