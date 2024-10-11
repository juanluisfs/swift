//
//  ImageManager.swift
//  pruebas
//
//  Created by Juan Luis on 25/09/24.
//

import SwiftUI

class ImageManager: NSObject, ObservableObject {
    struct ImageShareTransferable: Transferable {
        static var transferRepresentation: some TransferRepresentation {
            ProxyRepresentation(exporting: \.image)
        }
        public var image: Image
        public var caption: String
    }
    
    @Published var imageSaved: Int = 0
    @Published var showError: Bool = false

    @MainActor func saveView(_ view: some View, scale: CGFloat) {
        if let uiImage = getUIImage(view, scale: scale) {
            writeToPhotoAlbum(image: uiImage)
        }
    }
    
    @MainActor func getTransferable(_ view: some View, scale: CGFloat, caption: String) -> ImageShareTransferable? {
        if let uiImage = getUIImage(view, scale: scale) {
            return ImageShareTransferable(image: Image(uiImage: uiImage), caption: caption)
        }
        return nil
    }
    
    
    @MainActor private func getUIImage(_ view: some View, scale: CGFloat) -> UIImage? {
        let renderer = ImageRenderer(content: view)
        // make sure and use the correct display scale for this device
        renderer.scale = scale
        if let uiImage = renderer.uiImage {
                return uiImage
        }
        return nil
    }
    
    
    private func writeToPhotoAlbum(image: UIImage) {
        //UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
        
        if let pngImage = image.getPNG() {
            UIImageWriteToSavedPhotosAlbum(pngImage, self, #selector(saveCompleted), nil)
        }
    }

    @objc private  func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("saving finished with error: \(error)")
            self.showError = true
        } else {
            print("Save finished!")
            imageSaved = imageSaved + 1
        }
    }
}

extension UIImage {
    func getPNG() -> UIImage? {
        guard let imageData = self.pngData() else { return nil }
        guard let imagePNG = UIImage(data: imageData) else { return nil }
        return imagePNG
    }
}
