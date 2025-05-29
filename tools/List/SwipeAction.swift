.swipeActions(allowsFullSwipe: false) {
  Button(role: .destructive) {
    // Action
  } label: {
    Label("Delete", systemImage: "trash.fill")
  }
  .tint(.red)
}

.swipeActions(edge: .leading) {
  Button {
    //
  } label: {
    Label("Add \(i)", systemImage: "plus.circle")
  }
  .tint(.indigo)
}
.swipeActions(edge: .trailing) {
  Button {
    total -= i
  } label: {
    Label("Subtract \(i)", systemImage: "minus.circle")
  }
}
