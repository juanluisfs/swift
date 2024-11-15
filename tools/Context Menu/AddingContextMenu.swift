Text("Options")
    .contextMenu {
        Button {
            print("Change country setting")
        } label: {
            Label("Choose Country", systemImage: "globe")
        }

        Button {
            print("Enable geolocation")
        } label: {
            Label("Detect Location", systemImage: "location.circle")
        }
    }
