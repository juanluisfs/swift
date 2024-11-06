struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                NavigationLink("Details") {
                    DetailsScreen()
                }
                NavigationLink("Profiles") {
                    ProfileScreen()
                }
                NavigationLink("Settings") {
                    SettingsScreen()
                }
            }
            .navigationTitle("Main View")
        }
    }
}
