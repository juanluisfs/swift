import SwiftUI
import AVFAudio

struct SoundModel: Hashable {
    let name: String
    
    func getURL() -> URL {
        return URL(string: Bundle.main.path(forResource: name, ofType: "wav")!)!
    }
}

let arrayOfSounds: [SoundModel] = [
    .init(name: "1"),
    .init(name: "2"),
    .init(name: "3"),
    .init(name: "4"),
    .init(name: "5"),
    .init(name: "6")
]

class SoundPlayer {
    var player: AVAudioPlayer?
    
    func play(withURL url: URL) {
        player = try! AVAudioPlayer(contentsOf: url)
        player?.prepareToPlay()
        player?.play()
    }
}

struct AudioPlayer: View {
    
    private let player = SoundPlayer()
    
    var body: some View {
        List {
            ForEach(arrayOfSounds, id: \.self) { sound in
                Button("Play Sound \(sound.name)") {
                    player.play(withURL: sound.getURL())
                }
            }
        }
    }
}



#Preview {
    AudioPlayer()
}
