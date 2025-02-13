struct LogoEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) private var family
    
    func loadImage() -> Image? {
        if let userDefaults = UserDefaults(suiteName: "group.com.myapp"),
           let base64String = userDefaults.string(forKey: "widgetImageBase64"),
           let imageData = Data(base64Encoded: base64String),
           let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        }
        return nil
    }

    var body: some View {
        ZStack {
            switch family {
            case .accessoryCircular:
                VStack {
                    if let image = loadImage() {
                        image
                            .resizable()
                            .scaledToFit()
                            .padding(12)
                    } else {
                        Text("No Image Available")
                            .padding(12)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            default:
                Text("No Widget Available")
            }
        }
        .widgetURL(URL(string: "deeplink"))
    }
}

struct LogoLockWidget: Widget {
    let kind: String = "LogoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                LogoEntryView(entry: entry)
                    .containerBackground(.fill, for: .widget)
            } else {
                LogoEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .supportedFamilies([.accessoryCircular])
        .configurationDisplayName("Logo Lock Widget")
        .description("Description")
    }
}
