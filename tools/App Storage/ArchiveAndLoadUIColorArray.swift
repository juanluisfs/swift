static func archiveColor(object: [UIColor]) -> Data {
  do {
    let data = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
    return data
  } catch {
    fatalError("Can’t encode data: \(error)")
  }
}
    
static func loadColor(data: Data) -> [UIColor] {
  do {
    let allowedClasses = [NSArray.self, UIColor.self]
    guard let array = try NSKeyedUnarchiver.unarchivedObject(ofClasses: allowedClasses, from:data) as? [UIColor] else {
      return []
    }
    return array
  } catch {
    fatalError("loadWStringArray - Can't encode data: \(error)")
  }
}
