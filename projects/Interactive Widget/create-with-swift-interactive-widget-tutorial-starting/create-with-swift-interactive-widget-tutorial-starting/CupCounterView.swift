import SwiftUI

struct CupCounterView: View {
    
    @Binding var count: Int
    @State var dimension : CGFloat
    
    var body: some View {
        ZStack {
            Image(systemName: "drop")
                .resizable()
                .scaledToFit()
                .frame(width: dimension, height: dimension)
                .font(.largeTitle)
                .foregroundStyle(.cyan)
            
            
            Image(systemName: "drop.fill")
                .resizable()
                .scaledToFit()
                .frame(width: dimension, height: dimension)
                .foregroundStyle(.cyan)
                .mask {
                    Circle()
                        .trim(from: 0.0, to: CGFloat(count) * 0.1)
                }
            
            Text("\(count)")
                .font(.largeTitle)
                .fontWeight(.black)
                .monospaced()
                .contentTransition(.numericText())
                .transaction { t in
                    t.animation = .default
                }
                .offset(y: 6)
        }
    }
}

#Preview {
    CupCounterView(count: .constant(5), dimension: 100)
}
