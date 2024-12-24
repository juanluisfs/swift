Circle()
  .frame(width: 400)
  .onTapGesture(
    print("Tapped")
  )

Circle()
  .frame(width: 400)
  .contentShape(.rect)
  .onTapGesture(
    print("Tapped")
  )
