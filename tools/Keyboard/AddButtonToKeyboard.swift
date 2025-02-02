.toolbar(content: {
  // FocusedState neccesary if the button is shown twice
  if isTyping {
    ToolbarItem(placement: .keyboard) {
      Button {
        if isTyping {
          // Action to execute when tapped
        } label: {
          // Label shown on the keyboard
          Text("Done")
            .fontWeight(.bold)
            .tint(.blue)
        }
        // Alignment of the button on the keyboard
        .frame(maxWidth: .infinity, alignment: .trailing)
      }
    }
})
