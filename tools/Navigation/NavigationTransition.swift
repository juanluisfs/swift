struct ContentView: View {
    @Namespace var namespace

    var body: some View {
        NavigationStack {
            NavigationLink {
                Text("Detail View")
                    .navigationTransition(.zoom(sourceID: "identifier", in: namespace))
            } label: {
                Image(systemName: "house")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .background(.blue)
                    .matchedTransitionSource(id: "identifier", in: namespace)
            }
        }
    }
}
