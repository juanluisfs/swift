List {
  Text("Movies")
    .badge(25)
}

List {
  Text("Movies")
    .badge(
      Text("25")
        .foregroundStyle(.purple)
        .bold()
    )
}

TabView {
  Text("Movies")
    .tabItem {
      Image(systemName: "movieclapper")
    )
    .badge(25)
}
