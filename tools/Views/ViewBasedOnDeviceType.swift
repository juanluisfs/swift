@main
struct AppMain: App {
  var body: some Scene {
    WindowGroup {
      if UIDevice.isiPhone {
        iPhoneView()
      } else {
        iPadView()
      }
    }
  }
}

extension UIDevice {
  static var isiPhone: Bool {
    UIDevice.current.userInterfaceIdiom == .phone
  }

  static var isiPad: Bool {
    UIDevice.current.userInterfaceIdiom == .pad
  }
}
