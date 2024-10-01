.onReceive(NotificationCenter.default.publisher(
  for: UIScene.willEnterForegroundNotification)) { _ in
  let state = Activity<DynamicMeAttributes>.activities.first(where: { $0.id == activityID })?.activityState
    if (state != .active && state != .stale) {
      // Here goes the code that you want to run when the activity is active or stale
      // Aquí va el código que deseas ejecutar cuando la actividad está activa o stale
    }
}
.onAppear {
  let state = Activity<DynamicMeAttributes>.activities.first(where: { $0.id == activityID })?.activityState
  if (state != .active && state != .stale) {
    // Here goes the code that you want to run when the activity is active or stale
    // Aquí va el código que deseas ejecutar cuando la actividad está activa o stale
  }
}
