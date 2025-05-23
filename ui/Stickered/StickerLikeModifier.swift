//
//  Sticker.swift
//  HandyFiles
//
//  Created by Juan Luis Flores on 22/05/25.
//

import SwiftUI

struct StrokeModifier: ViewModifier {
    private let id = UUID()
    var strokeSize: CGFloat = 1
    var strokeColor: AnyShapeStyle = AnyShapeStyle(Color.blue)
     
    func body(content: Content) -> some View {
        if strokeSize > 0 {
            appliedStrokeBackground(content: content)
        } else {
            content
        }
    }
     
    private func appliedStrokeBackground(content: Content) -> some View {
        content
            .background(
                Rectangle()
                    .foregroundStyle(strokeColor)
                    .mask(alignment: .center) {
                        mask(content: content)
                    }
            )
    }
     
    func mask(content: Content) -> some View {
        Canvas { context, size in
            context.addFilter(.alphaThreshold(min: 0.01))
            if let resolvedView = context.resolveSymbol(id: id) {
                context.draw(resolvedView, at: .init(x: size.width/2, y: size.height/2))
            }
        } symbols: {
            content
                .tag(id)
                .blur(radius: strokeSize)
        }
    }
}

extension View {
    func stroke(color: some ShapeStyle, width: CGFloat = 1) -> some View {
        modifier(StrokeModifier(strokeSize: width, strokeColor: AnyShapeStyle(color)))
    }
     
    func stickered(width: CGFloat = 3) -> some View {
        self
            .stroke(color: .white, width: width)
            .stroke(color: Color.gray.opacity(0.3), width: 1)
    }
 
}

struct Sticker: View {
    var body: some View {
        ZStack {
            VStack {
                Image(systemName: "apple.logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 256)
                    .stickered()
                
                Text("🐲")
                    .font(.largeTitle)
                    .stickered()
                
                Text("Hello!").font(.title).stickered()
            }
            .padding()
        }
        .background(.black)
        .padding()
    }
}

#Preview {
    Sticker()
}
