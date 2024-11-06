#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)

    for i in 1..<10 {
        let user = User(name: "Example User \(i)")
        container.mainContext.insert(user)
    }

    return ContentView()
        .modelContainer(container)
}
