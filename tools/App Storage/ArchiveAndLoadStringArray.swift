// Convert String Array to Data  -  Convertir Array de Strings a Data
static func archiveStringArray(object : [String]) -> Data {
  do {
    let data = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
    return data
  } catch {
    fatalError("Can’t encode data: \(error)")
  }
}

// Convert Data to String Array  -  Convertir Data a Array de Strings
static func loadStringArray(data: Data) -> [String] {
  do {
    let allowedClasses = [NSArray.self, NSString.self]
    guard let array = try NSKeyedUnarchiver.unarchivedObject(ofClasses: allowedClasses, from:data) as? [String] else {
      return []
    }
    return array
  } catch {
    fatalError("loadWStringArray - Can't encode data: \(error)")
  }
}

// SwiftUI Example of Array Retrieve  -  Ejemplo de Recuperación del Array en SwiftUI
ForEach(0..<{getStrings(data: entry.nameArray)).count) { i in
     Text(getStrings(data: entry.nameArray)[i])
                                       
}

func getStrings(data: Data) -> [String] {
    return Storage.loadStringArray(data: data)
}
