struct ActionPopUp: View {
    
    @Binding var show: Bool
    
    let tint: Color
    let title: String
    let text: String
    let cta: String
    let showSecondary: Bool
    let ctaSecondary: String
    let showTapToClose: Bool
    
    let action: () -> Void?
    
    var body: some View {
        if show {
            withAnimation(.snappy) {
                VStack(spacing: 16) {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(tint.isDarkColor ? .white : .black)
                        .multilineTextAlignment(.center)
                    
                    if text != "" {
                        Text(text)
                            .font(.headline)
                            .fontWeight(.medium)
                            .opacity(0.9)
                            .foregroundStyle(tint.isDarkColor ? .white : .black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.top, -4)
                    }
                    
                    HStack(spacing: 20) {
                        Button {
                            show = false
                        } label: {
                            Text(ctaSecondary)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundStyle(tint.isDarkColor ? .white : .black)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(lineWidth: 2)
                                .foregroundStyle(tint.isDarkColor ? .white : .black)
                        )
                        .opacity(0.8)
                        
                        
                        Button {
                            action()
                        } label: {
                            Text(cta)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundStyle(tint)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .foregroundStyle(tint.isDarkColor ? .white : .black)
                        )
                    }
                    
                    if showTapToClose {
                        Text("Tap anywhere to close")
                            .font(.caption)
                            .fontWeight(.medium)
                            .opacity(0.9)
                            .foregroundStyle(tint.isDarkColor ? .white : .black)
                            .multilineTextAlignment(.center)
                            .padding(.top, -4)
                    }
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 20)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(tint.gradient)
                )
                .padding(.horizontal, 25)
                .transition(.move(edge: .bottom))
                .frame(maxHeight: .infinity, alignment: .center)
                .opacity(show ? 1:0)
                .onTapGesture {
                    show.toggle()
                }
            }
        }
    }
}
