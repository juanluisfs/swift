// Extension to get Integer Array from Data  -  Extensión para obtener Array de Integers desde Data 
extension ContiguousBytes {
    func objects<T>() -> [T] { withUnsafeBytes { .init($0.bindMemory(to: T.self)) } }
    var uInt16Array: [UInt16] { objects() }
    var int32Array: [Int32] { objects() }
}

// Extension to get Data from Integer Array  -  Extensión para obtener Data desde Array de Integers
extension Array {
    var data: Data { withUnsafeBytes { .init($0) } }
}

// Initialization of Integer Array  -  Inicialización de Array  de Integers
let uInt16Array: [UInt16] = [.min, 1, 2, 3, .max]  // [0, 1, 2, 3, 65535]
let int32Array: [Int32] = [.min, 1, 2, 3, .max]    // [-2147483648, 1, 2, 3, 2147483647]

// Convert Integer Array to Data  -  Convertir Array de Integers a Data
let uInt16ArrayData = uInt16Array.data  // 10 bytes
let int32ArrayData = int32Array.data    // 20 bytes

// Convert Data to Integer Array  -  Convertir Data a Array de Integers
let uInt16ArrayLoaded = uInt16ArrayData.uInt16Array  // [0, 1, 2, 3, 65535]
let int32ArrayLoaded = int32ArrayData.int32Array       // [-2147483648, 1, 2, 3, 2147483647]

// Access data  -  Acceso a los datos
let i1 = uInt16ArrayLoaded[0]   //  UInt16 0
let i2 = int32ArrayLoaded[0]    // Int32 -2147483648
let i3 = uInt16ArrayLoaded[4]   //  UInt16 65535
let i4 = int32ArrayLoaded[4]    // Int32 2147483647
