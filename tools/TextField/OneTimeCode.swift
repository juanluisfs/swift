@State private var code = ""

TextField("Enter verification code", text: $code)
  .textContentType(.oneTimeCode)
  .keyboardType(.numberPad)
