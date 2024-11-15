Menu {
  Section {
    Button(action: {}) {
      Label("Create a file", systemImage: "doc")
    }

    Button(action: {}) {
      Label("Create a folder", systemImage: "folder")
    }
  }

  Section(header: Text("Secondary actions")) {
    Button(action: {}) {
      Label("Remove old files", systemImage: "trash")
        .foregroundColor(.red)
    }
  }
}
