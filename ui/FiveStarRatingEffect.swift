@State var rating: Int = 0

HStack {
  ForEach(1...5, id: \.self) { index in
    Image(systemName: index <= rating ? "star.fill":"star")
      .font(.system(size: 40))
      .foregroundStyle(index <= rating ? .yellow : .gray.opacity(0.3))
      .symbolEffect(.bounce, options: .repeat(index <= rating ? 1 : 0), value: rating)
      .onTapGesture {
        rating = index
      }
  }
}
