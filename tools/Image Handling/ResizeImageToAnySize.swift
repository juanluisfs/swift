func resizeImage(image: UIImage?, to size: CGSize) -> UIImage? {
    guard let image = image else { return nil }
    
    // Resize the image to the target size
    UIGraphicsBeginImageContextWithOptions(size, false, image.scale)
    image.draw(in: CGRect(origin: .zero, size: size))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return resizedImage
}
