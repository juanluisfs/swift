Text(.now, style: .timer)
  .font(.largeTitle)
  .fontWeight(.black)
  .monospaced()
  .contentTransition(.numericText())
  .transaction { t in
    t.animation = .default
  }
