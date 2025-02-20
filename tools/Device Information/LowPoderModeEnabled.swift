if ProcessInfo.processInfo.isLowPowerModeEnabled {
  Image(systemName: "battery.50percent")
    .font(system(size: 200))
    .foregroundStyle(.orange, .gray)
} else {
  Image(systemName: "battery.50percent")
    .font(system(size: 200))
    .foregroundStyle(.white, .gray)
}
