@State private var disable = false

VStack {
    Button("Submit") {
        disable.toggle()
    }
    .disabled(false) // Abled - Habilitado
    
    Button("Submit") {
        //
    }
    .disabled(true) // Disabled - Deshabilitado

    Button("Submit" {
        //
    }
    .disabled(disable ? true:false) // Change based on condition - Cambia con bas en una condición
}
.font(.title)
