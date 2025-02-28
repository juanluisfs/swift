@State private var angle: Angle = .degrees(0.0)

Image(systemName: "steeringwheel")
  .font(.system(size: 300))
  .shadow(radius: 10)
  .rotationEffect(angle)
  .gesture (
    RotateGesture()
      .onChanged { value in
        self.angle = value.rotation
      }
  )
