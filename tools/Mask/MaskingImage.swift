Image(.sonoma)
  .resizable
  .scaledToFill()
  .ignoreSafeArea()
  .mask {
    Image(systemName: "apple.logo"
      .font(.system(size: 300))
  }
  .shadow(radius: 10)
