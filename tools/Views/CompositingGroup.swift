VStack {
    RoundedRectangle(cornerRadius: 25)
        .fill(.orange)
        .frame(width: 350, height: 100)
        .offset(y: 50)
        .zIndex(1)
    
    RoundedRectangle(cornerRadius: 25)
        .fill(.orange)
        .frame(width: 100, height: 350)
}
.compositingGroup()
.shadow(
    color: .black.opacity(0.55),
    radius: 30,
    x: 0,
    y: 5
)
