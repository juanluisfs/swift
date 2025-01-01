// Resize image function returning an UIImage
// Función de redimensión de imagen que regresa una UIImage

func resizeTo(size: CGSize) -> UIImage? {  // Give the desired size in GGSize Input - Ingresar el tamaño deseado en la entrada como CGSize
  UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
  self.draw(in: CGRect(origin: CPoint.zero, size: size))
  let resizedImage = UIGraphicsGetImageFromCurrent ImageContext()!
  UIGraphicsEndImageContext()
  return resizedImage
}