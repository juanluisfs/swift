import SwiftUI
import UIKit
    
extension Color: RawRepresentable 
{
    public init?(rawValue: String) {
        guard let data = Data(base64Encoded: rawValue) else {
            self = .black
            return
        }

        do {
            if let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data) {
                self = Color(color)
            } else {
                self = .black
            }
        } catch {
            self = .black
        }
    }

    public var rawValue: String {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false) as Data
            return data.base64EncodedString()
        } catch {
            return ""
        }
    }
}

// How to use it
@AppStorage("colorkey") var storedColor: Color = .black
    
    var body: some View {
        
        VStack {
            ColorPicker("Persisted Color Picker", selection: $storedColor, supportsOpacity: true)
        }
}
