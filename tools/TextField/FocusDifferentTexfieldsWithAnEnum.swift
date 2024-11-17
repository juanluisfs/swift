enum FocusableField: Hashable {
    case email
    case password
}

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @FocusState private var focus: FocusableField?

    var body: some View {
        NavigationView {
            Form {
                TextField("email", text: $email, prompt: Text("email"))
                    .focused($focus, equals: .email)
                SecureField("password", text: $password, prompt: Text("password"))
                    .focused($focus, equals: .password)
                Button("login", action: login)
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("next") {
                        if email.isEmpty {
                            focus = .email
                        } else if password.isEmpty {
                            focus = .password
                        } else {
                            focus = nil
                        }
                    }
                }
            }
            .navigationTitle("Sign in")
            .defaultFocus($focus, .email)
        }
    }

    private func login() {
        // your logic here
    }
