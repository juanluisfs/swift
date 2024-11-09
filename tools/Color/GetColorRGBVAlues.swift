struct ContentView: View {
    @Environment(\.self) var environment
    @State private var color = Color.red
    @State private var resolvedColor: Color.Resolved?

    var body: some View {
        VStack {
            ColorPicker("Select your favorite color", selection: $color)

            if let resolvedColor {
                Text("Red: \(resolvedColor.red)")
                Text("Green: \(resolvedColor.green)")
                Text("Blue: \(resolvedColor.blue)")
                Text("Opacity: \(resolvedColor.opacity)")
            }
        }
        .padding()
        .onChange(of: color, initial: true, getColor)
    }

    func getColor() {
        resolvedColor = color.resolve(in: environment)
    }
}
