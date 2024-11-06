struct EditingView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var user: User

    var body: some View {
        Form {
            TextField("Name", text: $user.name)
        }
    }
}
