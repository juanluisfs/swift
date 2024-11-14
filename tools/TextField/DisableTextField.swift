@State var isToogleOn = false
    @State var textFieldIsDisabled = false
    @State var textFieldValue = ""
    
    @FocusState private var focusField: Field?
    
    var body: some View {
        HStack {
            TextField("Placeholde", text: $textFieldValue)
                .focused($focusField, equals: .textField1)
                .disabled(textFieldIsDisabled)
            Toggle("Activate textField", isOn: $isToogleOn)
                .onChange(of: isToogleOn) { newValue in
                    focusField = nil
                    textFieldIsDisabled = !newValue
                }
        }
    }
