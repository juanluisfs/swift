List {
    // Section with Header
    Section(header: Text("Other tasks")) {
        TaskRow()
        TaskRow()
        TaskRow()
    }
    
    Section(header: Text("Other tasks"), footer: Text("End")) {
        Text("Row 1")
        Text("Row 2")
        Text("Row 3")
    }
}
