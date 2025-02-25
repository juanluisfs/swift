import SwiftUI

struct ContentView: View {
    
    @State var show = false
    
    var body: some View {
        Button("Show Details View") {
            show = true
        }
        .sheet(isPresented: $show) {
            Text("Details")
                .presentationDetents([.fraction(0.25)])
                .presentationDetents([.medium])
                .presentationDetents([.height(500)])
                .presentationCornerRadius(50)
        }
    }
}

#Preview {
    ContentView()
}
