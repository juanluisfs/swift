import SwiftUI

struct ContentView: View {
    
    let tripData: [TripData] = [
        TripData(day: "Day 1", expense: 450.0),
        TripData(day: "Day 2", expense: 380.0),
        TripData(day: "Day 3", expense: 520.0),
        TripData(day: "Day 4", expense: 480.0)
    ]
    
    var body: some View {
        VStack {
            ShareLink(item:generateCSV()) {
                Label("Export CSV", systemImage: "list.bullet.rectangle.portrait")
            }
        }
        .padding()
    }
    
    func generateCSV() -> URL {
        var fileURL: URL!
        // Heading of CSV file - Encabezado del archivo CSV
        let heading = "Day, Expense\n"
        // File rows - Filas del archivo
        let rows = tripData.map { "\($0.day),\($0.expense)" }
        // rows to string data
        let stringData = heading + rows.joined(separator: "\n")
        do {
            let path = try FileManager.default.url(for: .documentDirectory,
                                                   in: .allDomainsMask,
                                                   appropriateFor: nil,
                                                   create: false)
            fileURL = path.appendingPathComponent("Trip-Data.csv")
            // Append string data to file - Agregar datos de String al archivo
            try stringData.write(to: fileURL, atomically: true , encoding: .utf8)
            print(fileURL!)
        } catch {
            print("error generating csv file")
        }
        return fileURL
    }
}

struct TripData{
    var day: String
    var expense: Double
}

#Preview {
    ContentView()
}
