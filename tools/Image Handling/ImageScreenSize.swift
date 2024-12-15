GeometryReader { proxy in
    Image(.example)
        .resizable()
        .scaledToFit()
        .frame(width: proxy.size.width * 0.8)
        .frame(width: proxy.size.width, height: proxy.size.height)
}
