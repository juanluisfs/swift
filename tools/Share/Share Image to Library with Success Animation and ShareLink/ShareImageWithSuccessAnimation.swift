//
//  SaveShareView.swift
//  pruebas
//
//  Created by Juan Luis on 25/09/24.
//

import SwiftUI

struct BaseView: View {
    var body: some View {
        SaveShareView(content: CardView(imageName: "checkmark"), caption: "My checkmark")
    }
}

struct SaveShareView<Content: View>: View {
    let content: Content
    let caption: String

    @StateObject var imageManager: ImageManager = ImageManager()

    @Environment(\.displayScale) var displayScale
    @State private var showFinish: Bool = false
    @State private var showLogo: Bool = false
    @State private var imageShareTransferable: ImageManager.ImageShareTransferable?

    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                Text(caption)
                content
                    .frame(maxWidth: .infinity)

                HStack {
                    Button(action: {
                        imageManager.saveView(content, scale: displayScale)
                    }, label: {
                        Image(systemName: "arrow.down.to.line")
                        
                    })
                    
                    if let imageShareTransferable = imageShareTransferable {
                        Spacer()
                        ShareLink(
                            item: imageShareTransferable,
                            preview: SharePreview(
                                imageShareTransferable.caption,
                                image: imageShareTransferable.image)) {
                                    Image(systemName: "square.and.arrow.up")
                                }

                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)

            }
            .fixedSize()
            .padding(.horizontal, 50)
            
            ZStack {
                Rectangle()
                    .fill(Color(uiColor: .systemGray4))
                    .ignoresSafeArea(.all)
                
                Image(systemName: "checkmark.seal")
                    .padding()
                    .font(.system(size: 80))
                    .foregroundStyle(Color.white)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.red)
                    )
                    .opacity(showLogo ? 1 : 0)
                    .scaleEffect(showLogo ? 1 : 1.3)
                    .animation(.spring, value: showLogo)
            }
            .opacity(showFinish ? 1 : 0)

            if imageManager.showError {
                ZStack {
                    Rectangle()
                        .fill(Color(uiColor: .systemGray4))
                        .ignoresSafeArea(.all)
                    Image(systemName: "exclamationmark.triangle")
                        .padding()
                        .font(.system(size: 80))
                        .foregroundStyle(Color.white)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.red)
                        )
                }
            }
        }
        .foregroundStyle(Color.red)
        .font(.system(size: 30, weight: .bold))
        .animation(.bouncy, value: showFinish)
        .onAppear {
            imageShareTransferable = imageManager.getTransferable(content, scale: displayScale, caption: caption)
        }
        .onChange(of: imageManager.imageSaved) {
            showFinish = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                showLogo = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showLogo = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        showFinish = false
                    }
                }
            }
        }
    }
}

fileprivate struct CardView: View {
    let imageName: String
    
    var body: some View {
        
        VStack(spacing: 30) {
            Text(imageName)
            Image(systemName: imageName)
        }
        .foregroundStyle(Color.red)
        .font(.system(size: 20, weight: .bold))
        .padding(.vertical, 50)
        .padding(.horizontal, 30)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.red.opacity(0.1))
                .stroke(Color.red, style: StrokeStyle(lineWidth: 3))
        )
        .padding(1)
        
    }
}


#Preview {
    BaseView()
}
