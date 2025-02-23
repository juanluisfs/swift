//
//  BlurView.swift
//  SoundAndHaptics
//
//  Created by Juan Luis Flores on 22/02/25.
//

import SwiftUI
import UIKit

extension UIBlurEffect {
    public static func variableBlurEffect(radius: Double, imageMask: UIImage) -> UIBlurEffect? {
        let methodType = (@convention(c) (AnyClass, Selector, Double, UIImage) -> UIBlurEffect).self
        let selectorName = ["imageMask:", "effectWithVariableBlurRadius:"].reversed().joined()
        let selector = NSSelectorFromString(selectorName)
        guard UIBlurEffect.responds(to: selector) else { return nil }
        let implementation = UIBlurEffect.method(for: selector)
        let method = unsafeBitCast(implementation, to: methodType)
        return method(UIBlurEffect.self, selector, radius, imageMask)
    }
}

struct VariableBlurView: UIViewRepresentable {
    let radius: Double
    let maskHeight: CGFloat
    let fromTop: Bool
    
    // Use a static cache for the mask image
    private static var maskCache: [String: UIImage] = [:]
    
    // Create the mask image asynchronously on initialization
    init(radius: Double, maskHeight: CGFloat, fromTop: Bool) {
        self.radius = radius
        self.maskHeight = maskHeight
        self.fromTop = fromTop
        
        let cacheKey = "\(maskHeight)-\(fromTop)"
        if VariableBlurView.maskCache[cacheKey] == nil {
            Task.detached(priority: .userInitiated) {
                let maskImage = await createGradientImage(maskHeight: maskHeight, fromTop: fromTop)
                await MainActor.run {
                    VariableBlurView.maskCache[cacheKey] = maskImage
                }
            }
        }
    }
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: nil)
        updateUIView(view, context: context)
        return view
    }
    
    func updateUIView(_ view: UIVisualEffectView, context: Context) {
        let cacheKey = "\(maskHeight)-\(fromTop)"
        if let cachedMask = VariableBlurView.maskCache[cacheKey] {
            view.effect = UIBlurEffect.variableBlurEffect(radius: radius, imageMask: cachedMask)
        } else {
            view.effect = nil
            
            Task {
                let maskImage = await createGradientImage(maskHeight: maskHeight, fromTop: fromTop)
                await MainActor.run {
                    VariableBlurView.maskCache[cacheKey] = maskImage
                    view.effect = UIBlurEffect.variableBlurEffect(radius: radius, imageMask: maskImage)
                }
            }
        }
    }
}

private func createGradientImage(maskHeight: CGFloat, fromTop: Bool) async -> UIImage {
    
    var safeAreaInsets: UIEdgeInsets {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return UIEdgeInsets.zero
        }
        
        return window.safeAreaInsets
    }
    
    let screen = await UIScreen.main.bounds
    
    let safeAreaTop = await MainActor.run { safeAreaInsets.top }
    let safeAreaBottom = await MainActor.run { safeAreaInsets.bottom }
    
    return await Task.detached(priority: .userInitiated) {
        autoreleasepool {
            let screenSize = CGSize(
                width: screen.width,
                height: screen.height
            )
            
            let format = UIGraphicsImageRendererFormat()
            format.scale = 0.0 // Use the device's scale
            let renderer = UIGraphicsImageRenderer(size: screenSize, format: format)
            
            return renderer.image { context in
                let cgContext = context.cgContext
                let colorSpace = CGColorSpaceCreateDeviceGray()
                
                let locations: [CGFloat]
                if fromTop {
                    locations = [0.0, safeAreaTop / screenSize.height, (maskHeight + safeAreaTop) / screenSize.height, 1.0]
                } else {
                    locations = [0.0, (screenSize.height - maskHeight - safeAreaBottom) / screenSize.height, (screenSize.height - safeAreaBottom) / screenSize.height, 1.0]
                }
                
                let colors: [CGFloat]
                if fromTop {
                    colors = [0.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0]
                } else {
                    colors = [0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 1.0]
                }
                
                guard let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colors, locations: locations, count: locations.count) else {
                    return
                }
                
                let startPoint = CGPoint(x: screenSize.width / 2, y: 0)
                let endPoint = CGPoint(x: screenSize.width / 2, y: screenSize.height)
                
                cgContext.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
            }
        }
    }.value
}

struct VariableBlurModifier: ViewModifier {
    @State private var isReduceTransparencyEnabled = UIAccessibility.isReduceTransparencyEnabled
    var radius: Double
    var maskHeight: CGFloat
    var fromTop: Bool
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                NotificationCenter.default.addObserver(
                    forName: UIAccessibility.reduceTransparencyStatusDidChangeNotification,
                    object: nil,
                    queue: .main
                ) { _ in
                    isReduceTransparencyEnabled = UIAccessibility.isReduceTransparencyEnabled
                }
            }
            .onDisappear {
                NotificationCenter.default.removeObserver(
                    self,
                    name: UIAccessibility.reduceTransparencyStatusDidChangeNotification,
                    object: nil
                )
            }
            .overlay(
                Group {
                    if !isReduceTransparencyEnabled {
                        VariableBlurView(radius: radius, maskHeight: maskHeight, fromTop: fromTop)
                            .ignoresSafeArea()
                    }
                }
            )
    }
}

extension View {
    func variableBlur(radius: Double, maskHeight: CGFloat, fromTop: Bool = true) -> some View {
        self.modifier(VariableBlurModifier(radius: radius, maskHeight: maskHeight, fromTop: fromTop))
    }
}

#Preview {
    VStack(spacing: 0) {
        Circle()
            .foregroundStyle(.red)
        Circle()
            .foregroundStyle(.green)
        Circle()
            .foregroundStyle(.blue)
    }
    .frame(maxWidth: .infinity, alignment: .center)
    .variableBlur(radius: 20, maskHeight: 800)
}
