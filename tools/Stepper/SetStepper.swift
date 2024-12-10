struct ContentView: View {
    
    @State var iPhoneCounter: Int = 1
    
    var body: some View {
        Form {
            Stepper("iPhone: \(iPhoneCounter)",
                    value: $iPhoneCounter,
                    in: 1...5)
        }
    }
}

struct ContentView: View {
    
    @State var iPhoneCounter: Int = 1
    
    var body: some View {
        Form {
            Stepper("iPhone: \(iPhoneCounter)") {
                iPhoneCounter += 1
                print("[Incrementar] Número \(iPhoneCounter)")
            } onDecrement: {
                iPhoneCounter -= 1
                print("[Decrementar] Número \(iPhoneCounter)")
            }
        }
    }
}
