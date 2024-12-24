// Hitbox fitting the shape
// Zona de impacto que se ajusta a la figura
Circle()
  .frame(width: 400)
  .onTapGesture(
    print("Tapped")
  )

// Hitbox fitting the shape described on contentShape
// Zona de impacto que se ajusta a la figura descrita en contentShape
Circle()
  .frame(width: 400)
  .contentShape(.rect)
  .onTapGesture(
    print("Tapped")
  )
