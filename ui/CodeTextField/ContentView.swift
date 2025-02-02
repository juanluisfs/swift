import SwiftUI

struct ContentView: View {
    
    @State private var code: String = ""
    
    @State private var valid = false
    
    var body: some View {
        VStack {
            VerificationField(type: .six, style: .rounded, value: $code) { result in
                if result.count < 6 {
                    return .typing
                } else if result == "123456" {
                    valid = true
                    return .valid
                } else {
                    return .invalid
                }
            }
        }
        .background(
            Color(valid ? .green : .red)
        )
    }
}

#Preview {
    ContentView()
}
