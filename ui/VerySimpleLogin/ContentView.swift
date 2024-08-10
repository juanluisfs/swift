import SwiftUI

struct ContentView: View {
    
    var body: some View {
        LoginScreen()
    }
}

struct LoginScreen: View {
    
    @State private var isLoggedIn: Bool = false
    @State private var username: String = ""
    
    private func login() async {
        // Here you call for the authentication service
        // Aqui se llama al servicio de autenticacion
        try! await Task.sleep(for: .seconds(2.0))
        isLoggedIn = true
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("User name", text: $username)
                
                Button("Login") {
                    Task {
                        await login()
                    }
                }
            }.navigationTitle("Login")
                .navigationDestination(isPresented: $isLoggedIn) {
                    Text("Home Screen")
                }
        }
    }
}

#Preview {
    ContentView()
}
