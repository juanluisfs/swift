struct ControlButton: View {
  let action: () -> Void

  var body: some View {
    Button(action: {
      self.action()
    }) {
      Text("Tap Me")
    }
  }
}
