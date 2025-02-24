//
//  ContentView.swift
//  Pruebas
//
//  Created by Juan Luis on 23/02/25.
//

import SwiftUI

struct ContentView: View {
    
    private let images = (1...7).map{"\($0)"}
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = 1.25 * width
            let offset = -width / 2
            VStack(spacing: 20) {
                ScrollView(.horizontal) {
                    HStack(spacing: 22) {
                        ForEach(images.indices, id: \.self) { number in
                            ZStack {
                                Image("h\(number + 1)")
                                    .frame(width: width, height: height)
                                    .scrollTransition(.interactive, axis: .horizontal) { content, phase in
                                        content.offset(x: phase.value * offset)
                                    }
                                    .overlay {
                                        LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                                    }
                                    .overlay(alignment: .bottom) {
                                        Text("\(Text("Image \(number + 1)").foregroundStyle(.orange))\n\(Text("Nature").font(.system(size: 23)))")
                                            .font(.title)
                                            .bold()
                                            .foregroundStyle(.white)
                                            .multilineTextAlignment(.center)
                                            .padding(.bottom, 44)
                                    }
                            }
                            .containerRelativeFrame(.horizontal)
                            .clipShape(RoundedRectangle(cornerRadius: 32))
                            .shadow(color: colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5), radius: 5, x: 0, y: 2)
                        }
                    }
                    .scrollTargetLayout()
                    .padding([.top, .bottom], 20)
                }
                .frame(height: height)
                .contentMargins(.horizontal, 44)
                .scrollTargetBehavior(.paging)
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    ContentView()
}
