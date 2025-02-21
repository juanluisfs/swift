ViewThatFits(in: .horizontal) {
  // This view will be displayed if it fits in horizontal 
  HStack {
    Text("Restore previous purchases")

    Button("Restore Purchases") {
      // Action
    }
    .buttonStyle(.borderedProminent)
  }
  
  // This view will be displayed if it doesn't fit
  VStack {
    Text("Restore previous purchases")

    Button("Restore Purchases") {
      // Action
    }
    .buttonStyle(.borderedProminent)
  }
}
