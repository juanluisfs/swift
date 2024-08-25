// Basic Enum
// Enum básico
enum CompassPoint {
  case north
  case south
  case east
  case west
}

// Using Enum Values with Picker View
// Usando valores de Enum con Picker View
import SwiftUI
enum FoodCategory: String, CaseIterable, Identifiable {
    case italian = "Italian"
    case chinese = "Chinese"
    case indian = "Indian"
    case american = "American"

    var id: Self { self }
}
struct ContentView: View {
    @State private var selectedCategory: FoodCategory = .italian

    var body: some View {
        VStack(spacing: 50) {
            Text("Selected Category: \(selectedCategory.rawValue)")
            Picker("Food Category", selection: $selectedCategory) {
                ForEach(FoodCategory.allCases) { category in
                    Text(category.rawValue)
                }
            }
        }
    }
}

// More about Enums - Más de los Enums
[Understanding] (url:https://www.swiftyplace.com/blog/understanding-swift-enumeration-enum-with-raw-value-and-associated-values)
