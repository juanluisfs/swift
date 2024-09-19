import PhotosUI
import SwiftUI

struct QRGeneration: View {
    @State var pickerImage: PhotosPickerItem?
    @State var text: String = "https://www.apple.com"
    @State var qr: UIImage?
    
    @AppStorage("name") private var name = "John Doe"
    
    var body: some View {
        VStack {
            TextField("Type the text to convert to QR", text: $text)
                .multilineTextAlignment(.center)
                .submitLabel(.done)
                .onSubmit {
                    qr = generateQRCode(from: text)
                }
            
            Image(uiImage: generateQRCode(from: "\(text)"))
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .frame(width: 200, height: 200)
        }
        .padding()
    }
}

func generateQRCode(from string: String) -> UIImage {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    filter.message = Data(string.utf8)

    if let outputImage = filter.outputImage {
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }
    }

    return UIImage(systemName: "xmark.circle") ?? UIImage()
}


#Preview {
    QRGeneration()
}
