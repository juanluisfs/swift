.swipeActions(allowsFullSwipe: false) {
  Button(role: .destructive) {
    // Action
  } label: {
    Label("Delete", systemImage: "trash.fill")
  }
  .tint(.red)
}
