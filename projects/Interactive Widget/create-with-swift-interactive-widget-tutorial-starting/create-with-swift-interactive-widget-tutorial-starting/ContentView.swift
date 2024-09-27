import SwiftUI

struct ContentView: View {
    
    @AppStorage("count", store: UserDefaults(suiteName: "group.jlfs.watercup.shared")) var count = 0
    
    var body: some View {
        VStack(spacing: 60) {
            
            Text("Current Value: \(count)")
                .font(.title3)
                .bold()
            
            CupCounterView(count: $count, dimension: 180)
            
            HStack(spacing: 24) {
                Button("Reset") {
                    WaterCupTracker.shared.resetCount()
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(.secondary)
                
                Button("Increment") {
                    WaterCupTracker.shared.incrementCount()
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(.cyan)
            }
            
        }
        .navigationTitle("WaterTracker")
        .padding()
    }
}

#Preview {
    ContentView()
}
