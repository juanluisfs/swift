extension UIImage {
    var squared: UIImage? {
        guard let cgImage = cgImage else { return nil }
        let length = min(cgImage.width, cgImage.height)
        let x = cgImage.width / 2 - length / 2
        let y = cgImage.height / 2 - length / 2
        let cropRect = CGRect(x: x, y: y, width: length, height: length)
        
        guard let croppedCGImage = cgImage.cropping(to: cropRect) else {  return nil }
        return UIImage(cgImage: croppedCGImage, scale: scale, orientation: imageOrientation)
    }
}
