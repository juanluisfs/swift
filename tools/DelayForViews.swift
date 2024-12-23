@State var tap = false

DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
  withAnimation(animation) {
    self.minusTap.toggle()
  }
}

1