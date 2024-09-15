//
//  ContentView.swift
//  ShinyCard
//
//  Created by Meng To on 2023-03-04.
//

import SwiftUI

struct ContentView: View {
    @State var translation: CGSize = .zero
    @State var isDragging = false
    @State var tap = false
    @GestureState var press = false
    
    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 3)
            .updating($press) { currentState, gestureState, transaction in
                gestureState = currentState
                transaction.animation = .spring()
            }
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                translation = value.translation
                isDragging = true
            }
            .onEnded { value in
                withAnimation {
                    translation = .zero
                    isDragging = false
                }
            }
    }
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.1599538028, green: 0.1648334563, blue: 0.1861925721, alpha: 1)).ignoresSafeArea()
            
            Image("Background 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 600)
                .frame(maxWidth: 390)
                .overlay(CameraView().opacity(0.5).scaleEffect(1.5).blur(radius: 10))
                .overlay(
                    ZStack {
                        Image("Logo 1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 180)
                            .offset(x: translation.width/8, y: translation.height/15)
                        Image("Logo 2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 400)
                            .offset(x: translation.width/10, y: translation.height/20)
                        Image("Logo 3")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 392, height: 600)
                            .blendMode(.overlay)
                            .offset(x: translation.width/15, y: translation.height/30)
                    }
                        .overlay(
                            Rectangle()
                                .fill(.linearGradient(colors: [.white.opacity(0.2), .clear, .white.opacity(0.5)], startPoint: .topLeading, endPoint: UnitPoint(x: press ? 2 : 1, y: press ? 2 : 1)))
                        )
                )
                .overlay(gloss1.blendMode(.softLight))
                .overlay(gloss2.blendMode(.luminosity))
                .overlay(gloss2.blendMode(.overlay))
                .overlay(LinearGradient(colors: [.clear, .white.opacity(0.5), .clear], startPoint: .topLeading, endPoint: UnitPoint(x: abs(translation.height)/100+1, y: abs(translation.height)/100+1)))
                .overlay(
                    ZStack {
                        RoundedRectangle(cornerRadius: 50)
                            .strokeBorder(.linearGradient(colors: [.clear, .white.opacity(1), .clear, .white.opacity(1), .clear], startPoint: .topLeading, endPoint: UnitPoint(x: abs(translation.width)/100+0.5, y: abs(translation.height)/100+0.5)))
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(.linearGradient(colors: [.clear, .white.opacity(1), .clear, .white.opacity(1), .clear], startPoint: .topLeading, endPoint: UnitPoint(x: abs(translation.width)/100+0.8, y: abs(translation.height)/100+0.8)), lineWidth: 10)
                            .blur(radius: 10)
                    }
                )
                .overlay(
                    LinearGradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 0.5152369619)), Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 0.5))], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .blendMode(.overlay)
                )
                .cornerRadius(50)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 50)
                            .fill(.black)
                            .offset(y: 50)
                            .blur(radius: press ? 20 : 50)
                            .opacity(1)
                            .blendMode(.overlay)
                        RoundedRectangle(cornerRadius: 50)
                            .fill(.black)
                            .offset(y: 30)
                            .blur(radius: 30)
                            .opacity(0.5)
                            .blendMode(.overlay)
                        RoundedRectangle(cornerRadius: 50)
                            .fill(.black)
                            .offset(y: 10)
                            .blur(radius: 10)
                            .opacity(0.5)
                            .blendMode(.overlay)
                    }
                )
                .scaleEffect(0.9)
                .rotation3DEffect(.degrees(isDragging ? 10 : 0), axis: (x: -translation.height, y: translation.width, z: 0))
                .gesture(drag)
                .simultaneousGesture(longPress)
        }
        .preferredColorScheme(.dark)
    }
    
    var gloss1: some View {
        Image("Gloss 1")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .mask(
                LinearGradient(colors: [.clear, .white, .clear, .white, .clear, .white, .clear], startPoint: .topLeading, endPoint: UnitPoint(x: abs(translation.height)/100+1, y: abs(translation.height)/100+1))
                    .frame(width: 392)
            )
    }
    
    var gloss2: some View {
        Image("Gloss 2")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .mask(
                LinearGradient(colors: [.clear, .white, .clear, .white, .clear, .white, .clear], startPoint: .topLeading, endPoint: UnitPoint(x: abs(translation.height)/100+1, y: abs(translation.height)/100+1))
                    .frame(width: 392)
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
