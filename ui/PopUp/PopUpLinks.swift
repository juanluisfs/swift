import SwiftUI

struct SupportPopUp: View {
    
    @State var show: Bool = true
    let tint: Color = Color.blue
    
    let title: String = "Title"
    let text: String = "Text"
    
    var body: some View {
        if show {
            withAnimation(.snappy) {
                VStack(spacing: 16) {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(tint.isDarkColor ? .white : .black)
                        .multilineTextAlignment(.center)
                    
                    Text(text)
                        .font(.headline)
                        .fontWeight(.medium)
                        .opacity(0.9)
                        .foregroundStyle(tint.isDarkColor ? .white : .black)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button {
                        if let url = URL(string: "your url") {
                            show = false
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Text("DynamicMe Support")
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
                    
                    HStack(spacing: 16) {
                        Button {
                            if let url = URL(string: "your url") {
                                show = false
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            Image(tint.isDarkColor ? "tt_light" : "tt_dark")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(lineWidth: 2)
                                .foregroundStyle(tint.isDarkColor ? .white : .black)
                        )
                        .padding(.top, -8)
                        
                        Button {
                            if let url = URL(string: "your url") {
                                show = false
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            Image(tint.isDarkColor ? "x_light" : "x_dark")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(lineWidth: 2)
                                .foregroundStyle(tint.isDarkColor ? .white : .black)
                        )
                        .padding(.top, -8)
                        
                        Button {
                            if let url = URL(string: "your url") {
                                show = false
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            Image(tint.isDarkColor ? "ig_light" : "ig_dark")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(lineWidth: 2)
                                .foregroundStyle(tint.isDarkColor ? .white : .black)
                        )
                        .padding(.top, -8)
                    }
                    
                    Text("Tap anywhere to close")
                        .font(.caption)
                        .fontWeight(.medium)
                        .opacity(0.9)
                        .foregroundStyle(tint.isDarkColor ? .white : .black)
                        .multilineTextAlignment(.center)
                        .padding(.top, -4)
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
