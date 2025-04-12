List {
  Text("Update")
    .swipeActions(edge: .leading) {
      Button("Pin", systemImage: "pin") {
        //
      }
      .tint(.purple)
    }
    .swipeActions(edge: .trailing) {
      Button("Delete", systemImage: "trash") {
        //
      }
      .tint(.red)
    }
}
