import SwiftUI

struct DragGestureView: View {
    
    @State var viewSate = CGSize.zero
    
    var body: some View {
        ZStack {
            CardBack()
                .animation(.spring, value: viewSate)
                .offset(y: viewSate.height > 100 ? -100 : (viewSate.height < -100 ? 100 : 0))
                .offset(y: -50)
                .onTapGesture {
                    self.viewSate = .zero
                }
            
            Card()
                .offset(y: viewSate.height)
                .animation(.spring, value: viewSate.height)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            self.viewSate = value.translation
                        })
                        .onEnded({ value in
                            if self.viewSate.height > 200 {
                                self.viewSate = CGSize(width: 0, height: 600)
                            } else {
                                self.viewSate = .zero
                            }
                        })
                )
        }
        .padding(.top, 100.0)
        .background(Color.black)
    }
}

struct CardBack: View {
    var body: some View {
        VStack {
            Text("Build an app with SwiftUI")
                .frame(maxWidth: .infinity)
            
            Spacer()
        }
        .background {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.blue)
        }
    }
}

struct Card: View {
    var body: some View {
        VStack {
            Text("Build an app with SwiftUI")
                .frame(maxWidth: .infinity)
            
            Spacer()
        }
        .background {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    DragGestureView()
}
