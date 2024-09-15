//
//  GlassView.swift
//  GlassViewProject
//
//  Created by Juan Luis on 21/08/24.
//

import SwiftUI

struct GlassView: View {
    let cornerRadius: CGFloat
    let fill: Color
    let opacity: CGFloat
    let shadowRadius: CGFloat
    
    init(cornerRadius: CGFloat, fill: Color, opacity: CGFloat, shadowRadius: CGFloat) {
        self.cornerRadius = cornerRadius
        self.fill = fill
        self.opacity = opacity
        self.shadowRadius = shadowRadius
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(fill)
            .opacity(opacity)
            .shadow(radius: shadowRadius)
    }
}
