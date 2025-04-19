struct ContentView: View {
    @State var scrollAmount = 0.0

    var body: some View {
        Text("Scroll: \(scrollAmount)")
            .focusable(true)
            .digitalCrownRotation($scrollAmount)
            .digitalCrownRotation($scrollAmount, from: 1, through: 5, by: 0.1, sensitivity: .low, isContinuous: true, isHapticFeedbackEnabled: true)
    }
}
