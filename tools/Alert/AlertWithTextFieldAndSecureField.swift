struct ContentView: View {
    @State private var isAuthenticating = false
    @State private var username = ""
    @State private var password = ""

    var body: some View {
        Button("Log in") {
            isAuthenticating.toggle()
        }
        .alert("Log in", isPresented: $isAuthenticating) {
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
            Button("OK", action: authenticate)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Please enter your username and password.")
        }
    }

    func authenticate() {
        if username == "twostraws" && password == "sekrit" {
            print("You're in!")
        } else {
            print("Who are you?")
        }
    }
}
