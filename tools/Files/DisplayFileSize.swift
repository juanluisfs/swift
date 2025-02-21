VStack {
  Image(systemName: "arrow.down.circle.fill")
    .foregroundStyle(.green)
    .font(.system(size: 200))
  
  Text(ByteCountFormatter.string(fromByteCount: 1_000_000, countStyle: .file))
    .font(.system(size: 120)).bold
}
