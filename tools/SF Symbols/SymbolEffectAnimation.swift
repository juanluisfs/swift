import SwiftUI

struct ContentView: View {
    
    @State var show = false
    
    var body: some View {
        Image(systemName: "bell")
            .font(.system(size: 100))
            .symbolEffect(.wiggle, options: .nonRepeating, value: show)
            .onTapGesture {
                show.toggle()
            }
        
        Image(systemName: "bell")
            .font(.system(size: 100))
            .symbolEffect(.wiggle, options: .repeat(.continuous), value: show)
            .onTapGesture {
                show.toggle()
            }
        
        Image(systemName: "bell")
            .font(.system(size: 100))
            .symbolEffect(.wiggle, options: .repeat(2), value: show)
            .onTapGesture {
                show.toggle()
            }
        
        Image(systemName: "bell")
            .font(.system(size: 100))
            .symbolEffect(.wiggle, options: .repeat(.periodic(2, delay: 1)), value: show)
            .onTapGesture {
                show.toggle()
            }
        
        Image(systemName: "bell")
            .font(.system(size: 100))
            .symbolEffect(.wiggle, options: .repeat(.random(in: 0...5)), value: show)
            .onTapGesture {
                show.toggle()
            }
        
        Image(systemName: "bell")
            .font(.system(size: 100))
            .symbolEffect(.wiggle, options: .speed(0.1), value: show)
            .onTapGesture {
                show.toggle()
            }
    }
}

#Preview {
    ContentView()
}
