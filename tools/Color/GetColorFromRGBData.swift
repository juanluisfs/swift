func getColor(_ data: [Float]) -> Color {
    let color = Color(red: Double(data[0]), green: Double(data[1]), blue: Double(data[2]))
    return color
}
