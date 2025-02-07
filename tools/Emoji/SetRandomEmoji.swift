@State var rendomEmoji: String

randomEmoji = String(UnicodeScalar(Array(0x1F300...0x1F3F0).randomElement()!)!)
