extension UIColor {
    var isDarkColor: Bool {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b     // Luminiscence parameters that can be changed to your liking
                                                           // Parámetros de luminiscencia que puedes cambiar a tu gusto
        return  lum < 0.50                                 // Lumiscence threshold that determines if the color is dark or not
                                                           // Umbral de luminiscencia que determina si el color es oscuro o no
    }
}

// Required if you're working with Color
// Requerido si estás trabajando con Color
extension Color {
    var isDarkColor : Bool {
        return UIColor(self).isDarkColor
    }
}