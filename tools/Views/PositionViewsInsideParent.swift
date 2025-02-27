ZStack {
  Color.mint.opacity(0.5)

  Rectangle()
    .fill(.purple)
    .frame(width: 100, height: 100)
    .position(CGPoint(x: 100, y: 100))

  Circle()
    .fill(.blue)
    .frame(width: 100, height: 100)
    .position(CGPoint(x: 250, y: 250))
}
.frame(width: 350, height: 350)
