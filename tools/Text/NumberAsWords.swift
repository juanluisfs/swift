import SwiftUI

struct ContentView: View {
    var body: some View {
        Text(formatNumberAsWords(1429))
            .font(.system(size: 80))
    }
    
    private func formatNumberAsWords(_ number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        return numberFormatter.string(from: NSNumber(value: number)) ?? "N/A"
    }
}

#Preview {
    ContentView()
}
