// Deprecated iOS26
UIScreen.main.brightness = 1.0

// Updated Version
func setScreenBrightness(_ value: CGFloat) {
    let scene = UIApplication.shared.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .first
  
    if let screen = scene?.screen {
        screen.brightness = value
    }
}

// Example
setScreenBrightness(0.9)
