import PhotosUI
import WidgetKit
import SwiftUI

struct ImagePickerView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil

    var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
            Text("Select a Photo")
        }
        .onChange(of: selectedItem) {
            Task {
                if let selectedItem = selectedItem {
                    if let data = try? await selectedItem.loadTransferable(type: Data.self) {
                        let base64String = data.base64EncodedString()
                        
                        if let userDefaults = UserDefaults(suiteName: "group.com.myapp") {
                            userDefaults.set(base64String, forKey: "widgetImageBase64")
                            
                            WidgetCenter.shared.reloadAllTimelines()
                        }
                    }
                }
            }
        }
    }
}
