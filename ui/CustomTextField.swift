import SwiftUI

struct KardTextField: View {
    // Local variables
    @Environment(\.colorScheme) var theme
    @FocusState var isTyping: Bool
    @State var isShowing: Bool = false
    @State var accentColor = Color.black
    // Input variables
    let title: String
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $text)
                .padding(.leading)
                .frame(height: 48)
                .focused($isTyping)
                .background(isTyping ? .blue : Color.primary, in: RoundedRectangle(cornerRadius: 14).stroke(lineWidth: 2))
            
            Text(title)
                .padding(.horizontal, 5)
                .background(accentColor)
                .foregroundStyle(isTyping ? .blue : Color.primary)
                .padding(.leading)
                .offset(y: isShowing ? -24 : 0)
                .onChange(of: text, {   // Delete this onChange if not autoupdate is required
                    if !isTyping && text.isEmpty {
                        isShowing = false
                    } else {
                        isShowing = true
                    }
                })
                .onChange(of: isTyping, {
                    if !isTyping && text.isEmpty {
                        isShowing = false
                    } else {
                        isShowing = true
                    }
                })
                .onChange(of: theme, {
                    accentColor = (theme == .dark ? .black : .white)
                })
                .animation(.bouncy, value: isShowing)
        }
        .padding(.vertical, 2)
        .onAppear(perform: {
            accentColor = (theme == .dark ? .black : .white)
        })
        .onTapGesture {
            isTyping = true
        }
    }
}
