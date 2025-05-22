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
  }

  static var isiPad: Bool {
  }
}
