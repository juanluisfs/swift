// Add this extension - Añade está extensión
extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

// Way of use - Modo de uso
let string = "Hey!"
let thirdCharacter = string[2]