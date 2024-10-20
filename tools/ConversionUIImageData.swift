// Swift UIImage to Data, Data to UIImage

let image = UIImage(named: "photo")                  // Assets photo to UIImage
let data = image?.pngData()                          // UIImage to PNG Data
let data = image?.jpegData(compressionQuality: 1)    // UIImage to JPEG Data - Quality from 0 to 1
let uiImage: UIImage = UIImage(data: imageData)      // Data to UIImage