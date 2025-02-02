.toolbar(content: {
  if isTyping {
    ToolbarItem(placement: .keyboard) {
      Button {
        if isTyping {
          
        } label: {
          Text("Done")
            .fontWeight(.bold)
            .tint(.blue)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
      }
    }
})
