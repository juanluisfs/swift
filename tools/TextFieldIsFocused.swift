@State private var text: String = ""
@FocusState private var isTextFieldFocused: Bool // If true, the TextField is editing

var body: some View {
    VStack {
        TextField("hello", text: $text)
            .focused($isTextFieldFocused)
        
        if isTextFieldFocused {
            Button("Keyboard is up!") {
                isTextFieldFocused = false      // You can change its state and control the keyboard
            }
        }
    }
}
