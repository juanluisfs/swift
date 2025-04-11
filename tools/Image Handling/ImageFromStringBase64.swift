var image: UIImage? = nil
if let data = Data(base64Encoded: imageData64! ,options: .ignoreUnknownCharacters){
  image = UIImage(data: data)
}
