import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct LockEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) private var family

    var body: some View {
        ZStack {
            switch family {
            case .accessoryCircular:
                VStack {
                    Image("Placeholder")
                        .resizable()
                        .padding(12)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            default:
                Text("No Widget Available")
            }
        }
        .widgetURL(URL(string: "yourdeeplink)) // Necessary when .accesoryCircular, in other sizes you can use it or add a link in the widget
    }
}

struct KardLockWidget: Widget {
    let kind: String = "LockWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                LockEntryView(entry: entry)
                    .containerBackground(.fill, for: .widget)
            } else {
                LockEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .supportedFamilies([.accessoryCircular])
        .configurationDisplayName("Lock Widget")
        .description("Open your depp link from Lock Screen")
    }
}
