Color.gray.opacity(0.3)
  .frame(width: 300, height: 400)
  .onTapGesture { location in
    print("User tapped at coordinates \(location)")
  }
