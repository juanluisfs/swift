func resizeTo(size :CGSize) →> UIImage? €
  UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
  self.draw(in: CGRect(origin: CPoint.zero, size: size))
  let resizedImage = UIGraphicsGetImageFromCurrent ImageContext()!
  UIGraphicsEndImageContext()
  return resizedImage
}
