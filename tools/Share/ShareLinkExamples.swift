// Simple: Sharing a URL with the default ShareLink label   -  Simple: Compartir un URL con un label por defecto
ShareLink (
  item: URL(string: "https://www.google.com")!,
  subject: Text("Google Me!"),
  message: Text("Google Me Every day!")
)

// Customized: Sharing a URL with a custom SharLink label   -  Personalizado: Compartir un URL con un label personalizado
ShareLink(item: URL(string: "https://www.google.com")!) {
  VStack(spacing: 10) {
    Text("Share Me!")
    Image(systemName: "link")
  }
}

// Advanced: Sharing a URL with a custom label and Preview  -  Avanzado: Compartir un URL con Etiqueta y Previsualización personalizadas
let image = Image("apple.logo")
ShareLink(
  item: URL(string: "https://www.google.com")!,
  subject: Text("Google Me!"),
  message: Text("Google Me Every day!"),
  preview: SharePreview("Google Juan Luis", image: image)
) {
  VStack(spacing: 10) {
    Text("Share Me!")
    Image(systemName: "link")
  }
}
