// Resize image function returning an UIImage
// Función de redimensión de imagen que regresa una UIImage

func resizeTo(size :CGSize) →> UIImage? €
  UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
  self.draw(in: CGRect(origin: CPoint.zero, size: size))
  let resizedImage = UIGraphicsGetImageFromCurrent ImageContext()!
  UIGraphicsEndImageContext()
  return resizedImage
}
