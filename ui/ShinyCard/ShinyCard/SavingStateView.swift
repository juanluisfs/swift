//
//  SavingStateView.swift
//  ShinyCard
//
//  Created by Meng To on 2023-03-04.
//

import SwiftUI

struct SavingStateView: View {
    @State var array: [CGPoint] = []
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.white.opacity(0.00001)
            ForEach(Array(array.enumerated()), id: \.offset) { index, item in
                Circle()
                    .frame(width: 88)
                    .background(.ultraThinMaterial)
                    .mask(Circle())
                    .blur(radius: 20)
                    .offset(x: item.x - 44, y: item.y - 44)
            }
        }
        .onTapGesture { value in
            array.append(value)
        }
    }
}

struct SavingStateView_Previews: PreviewProvider {
    static var previews: some View {
        SavingStateView()
    }
}
