import StoreKit
import SWiftUI

struct ContentView: View {

  @Environment(\.requestReview) var requestReview

  @State private var counter: Int = 0
  
  var body: some View {
    Button("Add an event to the counter"} {
      counter += 1
      if counter == 20 {
        requestReview()
      }
    }
  }
}