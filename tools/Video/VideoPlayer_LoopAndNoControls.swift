@State var player = AVPlayer(url: Bundle.main.url(forResource: "video_name", withExtension: "mov")!)

VideoPlayer(player: player)
  .frame(height: 140)
  .disabled(true)
  .padding(.vertical, 8)
  .onAppear {
    if player.currentItem == nil {
      let item = AVPlayerItem(url: Bundle.main.url(forResource: "video_name", withExtension: "mov")!)
      player.replaceCurrentItem(with: item)
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      player.play()
    }
    NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
      player.seek(to: .zero)
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        player.play()
      }                                                                                                                          
    }
  }
