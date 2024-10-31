@FocusState private var isInputFocused: Bool

TextField("Enter only emojis", text: $userInput)
  .focused($isInputFocused)
  .keyboardType(.init(rawValue: 124) ?? .default)
  .lineLimit(1)
