extension UIImage {
    func getPNG() -> UIImage? {
        guard let imageData = self.pngData() else { return nil }
        guard let imagePNG = UIImage(data: imageData) else { return nil }
        return imagePNG
    }
}
