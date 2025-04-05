//
//  TipsView.swift
//  BuildingATipJar
//
//  Created by Juan Luis Flores on 11/03/25.
//

import SwiftUI

struct TipsView: View {
    
    @EnvironmentObject private var store: TipStore
    
    var didTapClose: () -> ()
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Spacer()
                Button(action: didTapClose) {
                    Image(systemName: "xmark")
                        .symbolVariant(.circle.fill)
                        .font(.system(.largeTitle, design: .rounded).bold())
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.gray, .gray.opacity(0.2))
                }
            }
            
            Text("Emjoying the app so far?")
                .font(.system(.title2, design: .rounded).bold())
                .multilineTextAlignment(.center)
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                .font(.system(.body, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
            
            ForEach(store.items) { item in
                TipsItemView(item: item)
            }
        }
        .padding(16)
        .background(Color.blue, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(8)
        .overlay(alignment: .top) {
            Image(systemName: "apple.logo")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(6)
                .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                .offset(y: -25)
        }
    }
}

#Preview {
    
    TipsView {
        //
    }
        .environmentObject(TipStore())
}
