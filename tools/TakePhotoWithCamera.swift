import SwiftUI
import PhotosUI

struct ContentView: View {
  
    @State private var showCamera = false
    @State private var selectedImage: UIImage?

    var body: some View {
        VStack {
            if let selectedImage{
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
            }
            
            Button("Open camera") {
                showCamera = true
            }
            
        }
        .fullScreenCover(isPresented: $showCamera) {
            accessCameraView(selectedImage: $selectedImage)
        }
    }
}

struct accessCameraView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true    // Allows the user to crop the taken image (true = Allowed / false - Not Allowed)
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }

    func makeCoordinator() -> Coordinator { return Coordinator(picker: self) }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessCameraView
    
    init(picker: accessCameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
}

#Preview {
    ContentView()
}