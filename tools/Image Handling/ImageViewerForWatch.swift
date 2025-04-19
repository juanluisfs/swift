struct ImageViewer: View {
    let image: UIImage
    @State private var scale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.ignoresSafeArea()

                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(scale)
                    .offset(offset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                offset = CGSize(
                                    width: lastOffset.width + value.translation.width,
                                    height: lastOffset.height + value.translation.height
                                )
                            }
                            .onEnded { _ in
                                lastOffset = offset
                            }
                    )
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .focusable(true)
            .digitalCrownRotation(
                $scale,
                from: 1.0,
                through: 5.0,
                by: 0.05,
                sensitivity: .low,
                isContinuous: false,
                isHapticFeedbackEnabled: true
            )
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation {
                        offset = .zero
                        lastOffset = .zero
                        scale = 1.0
                    }
                } label: {
                    Image(systemName: "arrow.uturn.backward")
                }
            }
        }

    }
}
