import SwiftUI

struct FindNavigatorView: View {
    
    @State private var text = "Esta es una prueba del Find Navigator en SwiftUI"
    @State private var showFindNavigator = false
    
    var body: some View {
        VStack {
            Button("Find Text", systemImage: "magnifyingglass") {
                showFindNavigator = true
            }
            
            TextEditor(text: $text)
                .findNavigator(isPresented: $showFindNavigator)
        }
        .font(.largeTitle)
        .padding()
    }
}

#Preview {
    FindNavigatorView()
}
