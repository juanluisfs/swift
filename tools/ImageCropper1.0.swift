import SwiftUI

struct CropImage: View {
    
    @Environment(\.presentationMode) var pm
    
    // Image Variables
    @Binding var image: UIImage?
    @Binding var original: UIImage?
    @State var imageWidth: CGFloat = 0
    @State var imageHeight: CGFloat = 0
    @State var rotationAngle: Angle = .zero
    
    let aspectRatio: CGFloat = 17 / 13
    
    // Dot Variables
    @State var dotSize: CGFloat = 25
    @State var touchingDot = false
    
    // Crop Area Variables
    @State var activeOffset: CGSize = CGSize(width: 0, height: 0)
    @State var finalOffset: CGSize = CGSize(width: 0, height: 0)
    @State var rectActiveOffset: CGSize = CGSize(width: 0, height: 0)
    @State var rectFinalOffset: CGSize = CGSize(width: 0, height: 0)
    @State var activeRectSize: CGSize = CGSize(width: 255, height: 195)
    @State var finalRectSize: CGSize = CGSize(width: 255, height: 195)
    
    @Binding var tintColor: Color
    
    var body: some View {
        VStack {
            Text("Crop Image")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(height: 40)
                .padding(.top, 20)
                .padding(.bottom, 15)
            
            Spacer()
            
            ZStack {
                Image(uiImage: image!)
                    .resizable()
                    .scaledToFit()
                    .overlay(GeometryReader { geo -> AnyView in
                        DispatchQueue.main.async {
                            self.imageWidth = geo.size.width
                            self.imageHeight = geo.size.height
                        }
                        return AnyView(EmptyView())
                    })
                
                ZStack {
                    Rectangle()
                        .foregroundStyle(.black.opacity(0.3))
                        .frame(width: imageWidth, height: imageHeight)
                    
                    Rectangle()
                        .foregroundColor(.white)
                        .blendMode(.destinationOut)
                        .offset(x: rectActiveOffset.width, y: rectActiveOffset.height)
                        .frame(width: activeRectSize.width, height: activeRectSize.height)
                }
                .compositingGroup()
                
                Rectangle()
                    .stroke(lineWidth: 4)
                    .foregroundColor(.white)
                    .background(Color.white.opacity(0.01))
                    .offset(x: rectActiveOffset.width, y: rectActiveOffset.height)
                    .frame(width: activeRectSize.width, height: activeRectSize.height)
                    .gesture(
                        DragGesture()
                            .onChanged { drag in
                                let workingOffset = CGSize(
                                    width: rectFinalOffset.width + drag.translation.width,
                                    height: rectFinalOffset.height + drag.translation.height
                                )
                                
                                let widthMargin = (imageWidth - 4 - activeRectSize.width) / 2
                                let heightMargin = (imageHeight - 4 - activeRectSize.height) / 2
                                
                                if workingOffset.width < -widthMargin {
                                    self.rectActiveOffset.width = -widthMargin
                                } else if workingOffset.width > widthMargin {
                                    self.rectActiveOffset.width = widthMargin
                                } else {
                                    self.rectActiveOffset.width = workingOffset.width
                                }
                                
                                if workingOffset.height < -heightMargin {
                                    self.rectActiveOffset.height = -heightMargin
                                } else if workingOffset.height > heightMargin {
                                    self.rectActiveOffset.height = heightMargin
                                } else {
                                    self.rectActiveOffset.height = workingOffset.height
                                }
                                
                                activeOffset.width = rectActiveOffset.width - activeRectSize.width / 2
                                activeOffset.height = rectActiveOffset.height - activeRectSize.height / 2
                            }
                            .onEnded { drag in
                                self.rectFinalOffset = rectActiveOffset
                                self.finalOffset = activeOffset
                            }
                    )
                
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                    .font(.system(size: 18))
                    .background(Circle()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(tintColor.gradient))
                    .frame(width: dotSize, height: dotSize)
                    .foregroundColor(tintColor.isDarkColor ? .white:.black)
                    .offset(x: activeOffset.width, y: activeOffset.height)
                    .opacity(touchingDot ? 1:0.4)
                    .animation(.easeInOut, value: touchingDot)
                    .gesture(
                        DragGesture()
                            .onChanged { drag in
                                touchingDot = true
                                let workingOffset = CGSize(
                                    width: finalOffset.width + drag.translation.width,
                                    height: finalOffset.height + drag.translation.width / aspectRatio
                                )
                                
                                let changeInXOffset = finalOffset.width - workingOffset.width
                                let changeInYOffset = finalOffset.height - workingOffset.height
                                
                                let newWidth = finalRectSize.width + changeInXOffset
                                let newHeight = newWidth / aspectRatio
                                
                                if newWidth > 40 && newHeight > 40 && newHeight <= imageHeight && newWidth <= imageWidth {
                                    self.activeOffset.width = workingOffset.width
                                    self.activeOffset.height = workingOffset.height
                                    
                                    activeRectSize.width = newWidth
                                    activeRectSize.height = newHeight
                                    
                                    rectActiveOffset.width = rectFinalOffset.width - changeInXOffset / 2
                                    rectActiveOffset.height = rectFinalOffset.height - changeInYOffset / 2
                                }
                            }
                            .onEnded { drag in
                                self.finalOffset = activeOffset
                                finalRectSize = activeRectSize
                                rectFinalOffset = rectActiveOffset
                                touchingDot = false
                            }
                    )
            }
            .animation(.spring, value: rotationAngle)
            .frame(height: 600)
            .onAppear {
                activeOffset.width = rectActiveOffset.width - activeRectSize.width / 2
                activeOffset.height = rectActiveOffset.height - activeRectSize.height / 2
                finalOffset = activeOffset
            }
            
            Spacer()
            
            HStack(spacing: 8) {
                Label("-90", systemImage: "rotate.left")
                    .fontWeight(.bold)
                    .foregroundStyle(tintColor.isDarkColor ? .white:.black)
                    .labelStyle(.iconOnly)
                    .onTapGesture {
                        rotationAngle = Angle.degrees(-90)
                        image = image!.rotated(by: rotationAngle)
                    }
                
                Rectangle()
                    .frame(width: 2)
                    .opacity(0.75)
                    .padding(.vertical, 7)
                    .padding(.horizontal, 4)
                    .foregroundStyle(tintColor.isDarkColor ? .white:.black)
                
                Label("Crop", systemImage: "crop.rotate")
                    .fontWeight(.bold)
                    .foregroundStyle(tintColor.isDarkColor ? .white:.black)
                    .labelStyle(.titleAndIcon)
                    .onTapGesture {
                        crop()
                    }
                
                Rectangle()
                    .frame(width: 2)
                    .opacity(0.75)
                    .padding(.vertical, 7)
                    .padding(.horizontal, 4)
                    .foregroundStyle(tintColor.isDarkColor ? .white:.black)
                
                Label("+90", systemImage: "rotate.right")
                    .fontWeight(.bold)
                    .foregroundStyle(tintColor.isDarkColor ? .white:.black)
                    .labelStyle(.iconOnly)
                    .onTapGesture {
                        rotationAngle = Angle.degrees(90)
                        image = image!.rotated(by: rotationAngle)
                    }
            }
            .frame(height: 40)
            .padding(.horizontal, 16)
            .background(Capsule().fill(tintColor.gradient))
            
            Label("Restart", systemImage: "arrow.counterclockwise")
                .foregroundStyle(.white)
                .labelStyle(.titleAndIcon)
                .padding(.top, 12)
                .padding(.bottom, 30)
                .onTapGesture {
                    if image != original {
                        image = original
                    }
                }
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
        .background(.black)
    }
    
    func getCropStartCord() -> CGPoint {
        var cropPoint: CGPoint = CGPoint(x: 0, y: 0)
        cropPoint.x = imageWidth / 2 - (activeRectSize.width / 2 - rectActiveOffset.width)
        cropPoint.y = imageHeight / 2 - (activeRectSize.height / 2 - rectActiveOffset.height)
        return cropPoint
    }
    
    func crop() {
        guard let originalImage = image,
              let cgImage = originalImage.cgImage else {
            return
        }
        
        let scaler = CGFloat(cgImage.width) / imageWidth
        let cropRect = CGRect(
            x: getCropStartCord().x * scaler,
            y: getCropStartCord().y * scaler,
            width: activeRectSize.width * scaler,
            height: activeRectSize.height * scaler
        )
        
        if let croppedCGImage = cgImage.cropping(to: cropRect) {
            image = UIImage(cgImage: croppedCGImage, scale: originalImage.scale, orientation: originalImage.imageOrientation)
        }
        
        pm.wrappedValue.dismiss()
    }
}
