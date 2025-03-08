import SwiftUI

struct ScrollToExampleView: View {
    @State private var scrollTarget: Int? = nil
    
    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(1..<30) { i in
                            Text("Elemento \(i)")
                                .padding()
                                .frame(height: 200)
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.3))
                                .id(i) // Asignamos un ID a cada elemento
                        }
                    }
                }
                .frame(height: 400) // Para que haya scroll
                
                Button("Ir al elemento 20") {
                    withAnimation {
                        proxy.scrollTo(20, anchor: .top) // Desplaza hasta el elemento con ID 20
                    }
                }
                .padding()
            }
        }
    }
}


#Preview {
    ScrollToExampleView()
}
