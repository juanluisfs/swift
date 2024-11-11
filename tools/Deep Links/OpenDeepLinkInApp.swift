struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
        }
        .padding()

        /// Responds to any URLs opened with our app.
        /// Respuesta a cualquier URL abierto con la app
        .onOpenURL { incomingURL in
            print("App was opened via URL: \(incomingURL)")
            handleIncomingURL(incomingURL)
        }
    }
}
