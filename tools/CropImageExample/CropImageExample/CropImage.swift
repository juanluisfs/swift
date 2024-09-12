//
//  CropImage.swift
//  CropImageExample
//
//  Created by Juan Luis on 25/06/24.
//

import SwiftUI

struct CropImage: View {
    @Environment(\.presentationMode) var pm
    @State var imageWidth: CGFloat = 0
    @State var imageHeight: CGFloat = 0
    @Binding var image: UIImage
    
    @State var dotSize: CGFloat = 25
    var dotColor = Color.init(white: 1).opacity(0.9)
    
    @State var center: CGFloat = 0
    @State var activeOffset: CGSize = CGSize(width: 0, height: 0)
    @State var finalOffset: CGSize = CGSize(width: 0, height: 0)
    
    @State var rectActiveOffset: CGSize = CGSize(width: 0, height: 0)
    @State var rectFinalOffset: CGSize = CGSize(width: 0, height: 0)
    
    @State var activeRectSize: CGSize = CGSize(width: 235, height: 195)
    @State var finalRectSize: CGSize = CGSize(width: 235, height: 195)
    
    @State var touchingDot = false
    
    let aspectRatio: CGFloat = 94 / 78 // Relación de aspecto deseada, puedes cambiarla por la que necesites
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                Image(uiImage: image)
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
                        .foregroundStyle(.black.opacity(0.2))
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
                        .foregroundColor(.blue))
                    .frame(width: dotSize, height: dotSize)
                    .foregroundColor(.white)
                    .offset(x: activeOffset.width, y: activeOffset.height)
                    .opacity(touchingDot ? 1:0.2)
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
            .onAppear {
                activeOffset.width = rectActiveOffset.width - activeRectSize.width / 2
                activeOffset.height = rectActiveOffset.height - activeRectSize.height / 2
                finalOffset = activeOffset
            }
            
            
            Text("Crop")
                .padding(10)
                .foregroundColor(.white)
                .background(Capsule().fill(Color.blue))
                .padding(.top, 50)
                .onTapGesture {
                    crop()
                }
            
            Spacer()
        }
    }
    
    func getCropStartCord() -> CGPoint {
        var cropPoint: CGPoint = CGPoint(x: 0, y: 0)
        cropPoint.x = imageWidth / 2 - (activeRectSize.width / 2 - rectActiveOffset.width)
        cropPoint.y = imageHeight / 2 - (activeRectSize.height / 2 - rectActiveOffset.height)
        return cropPoint
    }
    
    func crop() {
        let cgImage: CGImage = image.cgImage!
        let scaler = CGFloat(cgImage.width) / imageWidth
        if let cImage = cgImage.cropping(to: CGRect(x: getCropStartCord().x * scaler, y: getCropStartCord().y * scaler, width: activeRectSize.width * scaler, height: activeRectSize.height * scaler)) {
            image = UIImage(cgImage: cImage)
        }
        pm.wrappedValue.dismiss()
    }
}


struct TestCrop : View{
    @State var imageWidth:CGFloat = 0
    @State var imageHeight:CGFloat = 0
    @State var image:UIImage
    @State var showCropper : Bool = true
    @State var originalImage: UIImage?
    
    var body: some View{
        VStack{
            Text("Open Cropper")
                .font(.system(size: 17, weight: .medium))
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .foregroundColor(.white)
                .background(Capsule().fill(Color.blue))
                .onTapGesture {
                    showCropper = true
                }
            
            
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
            
            Button(action: {
                image = originalImage!
            }, label: {
                Text("Restart")
            })
        }
        .onAppear(perform: {
            originalImage = image
        })
        .sheet(isPresented: $showCropper) {
            //
        } content: {
            CropImage(image: $image)
        }
    }
}

struct CropImage_Previews: PreviewProvider {
    static var originalImage = UIImage(named: "wwdc24")
    static var previews: some View {
        TestCrop(image: originalImage ?? UIImage())
    }
}

//
//  CropImage.swift
//  DynamicPics
//
//  Created by Juan Luis on 24/06/24.
//
/*
import SwiftUI

struct CropImage: View {
    @Environment(\.presentationMode) var pm
    @State var imageWidth:CGFloat = 0
    @State var imageHeight:CGFloat = 0
    @Binding var image : UIImage
    
    @State var dotSize:CGFloat = 13
    var dotColor = Color.init(white: 1).opacity(0.9)
    
    @State var center:CGFloat = 0
    @State var activeOffset:CGSize = CGSize(width: 0, height: 0)
    @State var finalOffset:CGSize = CGSize(width: 0, height: 0)
    
    @State var rectActiveOffset:CGSize = CGSize(width: 0, height: 0)
    @State var rectFinalOffset:CGSize = CGSize(width: 0, height: 0)
    
    @State var activeRectSize : CGSize = CGSize(width: 200, height: 200)
    @State var finalRectSize : CGSize = CGSize(width: 200, height: 200)
    
    var body: some View {
        ZStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .overlay(GeometryReader{geo -> AnyView in
                    DispatchQueue.main.async{
                        self.imageWidth = geo.size.width
                        self.imageHeight = geo.size.height
                    }
                    return AnyView(EmptyView())
                })
            
            Text("Crop")
                .padding(6)
                .foregroundColor(.white)
                .background(Capsule().fill(Color.blue))
                .offset(y: -250)
                .onTapGesture {
                    let cgImage: CGImage = image.cgImage!
                    let scaler = CGFloat(cgImage.width)/imageWidth
                    if let cImage = cgImage.cropping(to: CGRect(x: getCropStartCord().x * scaler, y: getCropStartCord().y * scaler, width: activeRectSize.width * scaler, height: activeRectSize.height * scaler)){
                        image = UIImage(cgImage: cImage)
                    }
                    pm.wrappedValue.dismiss()
                }
            
            Rectangle()
                .stroke(lineWidth: 2)
                .foregroundColor(.white)
                .background(Color.green.opacity(0.3))
                .offset(x: rectActiveOffset.width, y: rectActiveOffset.height)
                .frame(width: activeRectSize.width, height: activeRectSize.height)
                .gesture(
                    DragGesture()
                        .onChanged{drag in
                            let workingOffset = CGSize(
                                width: rectFinalOffset.width + drag.translation.width,
                                height: rectFinalOffset.height + drag.translation.height
                            )
                            self.rectActiveOffset.width = workingOffset.width
                            self.rectActiveOffset.height = workingOffset.height
                            
                            activeOffset.width = rectActiveOffset.width - activeRectSize.width / 2
                            activeOffset.height = rectActiveOffset.height - activeRectSize.height / 2
                        }
                        .onEnded{drag in
                            self.rectFinalOffset = rectActiveOffset
                            self.finalOffset = activeOffset
                        }
                )
            
            Image(systemName: "arrow.up.left.and.arrow.down.right")
                .font(.system(size: 12))
                .background(Circle().frame(width: 20, height: 20).foregroundColor(dotColor))
                .frame(width: dotSize, height: dotSize)
                .foregroundColor(.black)
                .offset(x: activeOffset.width, y: activeOffset.height)
                .gesture(
                    DragGesture()
                        .onChanged{drag in
                            let workingOffset = CGSize(
                                width: finalOffset.width + drag.translation.width,
                                height: finalOffset.height + drag.translation.height
                            )
                            
                            let changeInXOffset = finalOffset.width - workingOffset.width
                            let changeInYOffset = finalOffset.height - workingOffset.height
                            
                            if finalRectSize.width + changeInXOffset > 40 && finalRectSize.height + changeInYOffset > 40{
                                self.activeOffset.width = workingOffset.width
                                self.activeOffset.height = workingOffset.height
                                
                                activeRectSize.width = finalRectSize.width + changeInXOffset
                                activeRectSize.height = finalRectSize.height + changeInYOffset
                                
                                rectActiveOffset.width = rectFinalOffset.width - changeInXOffset / 2
                                rectActiveOffset.height = rectFinalOffset.height - changeInYOffset / 2
                            }
                            
                        }
                        .onEnded{drag in
                            self.finalOffset = activeOffset
                            finalRectSize = activeRectSize
                            rectFinalOffset = rectActiveOffset
                        }
                )
        }
        .onAppear {
            activeOffset.width = rectActiveOffset.width - activeRectSize.width / 2
            activeOffset.height = rectActiveOffset.height - activeRectSize.height / 2
            finalOffset = activeOffset
        }
    }
    
    func getCropStartCord() -> CGPoint{
        var cropPoint : CGPoint = CGPoint(x: 0, y: 0)
        cropPoint.x = imageWidth / 2 - (activeRectSize.width / 2 - rectActiveOffset.width )
        cropPoint.y = imageHeight / 2 - (activeRectSize.height / 2 - rectActiveOffset.height )
        return cropPoint
    }
}

struct TestCrop : View{
    @State var imageWidth:CGFloat = 0
    @State var imageHeight:CGFloat = 0
    @State var image:UIImage
    @State var showCropper : Bool = false
    var body: some View{
        VStack{
            Text("Open Cropper")
                .font(.system(size: 17, weight: .medium))
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .foregroundColor(.white)
                .background(Capsule().fill(Color.blue))
                .onTapGesture {
                    showCropper = true
                }
            
            
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }
        .sheet(isPresented: $showCropper) {
            //
        } content: {
            CropImage(image: $image)
        }
    }
}

struct CropImage_Previews: PreviewProvider {
    static var originalImage = UIImage(named: "swift")
    static var previews: some View {
        TestCrop(image: originalImage ?? UIImage())
    }
}
*/
