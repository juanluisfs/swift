import SwiftUI

struct CustomTextField: View {
    
    @Environment(\.colorScheme) var theme
    @FocusState var isTyping: Bool
    @State var text = ""
    @State var back = Color.white
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                TextField("", text: $text)
                    .padding(.leading)
                    .frame(height: 55)
                    .focused($isTyping)
                    .background(isTyping ? .blue : Color.primary, in: RoundedRectangle(cornerRadius: 14).stroke(lineWidth: 2))
                
                Text("First Name")
                    .padding(.horizontal, 5)
                    .background(back.opacity(isTyping || !text.isEmpty ? 1 : 0))
                    .foregroundStyle(isTyping || !text.isEmpty ? .blue : Color.primary)
                    .padding(.leading)
                    .offset(y: isTyping ? -27 : 0)
                    .onTapGesture {
                        isTyping.toggle()
                    }
                    .onChange(of: theme, {
                        back = (theme == .dark ? .black : .white)
                    })
                    .animation(.linear(duration: 0.2), value: isTyping)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    CustomTextField()
}
