import SwiftUI

class GlowOverlayViewController: UIViewController {
    let vividRenderLayer : CAMetalLayer = CAMetalLayer()
    var renderPass : MTLRenderPassDescriptor?
    var drawable : CAMetalDrawable?
    var commandQueue : MTLCommandQueue?
    var defaultLibrary : MTLLibrary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVivid()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Ensure the Metal layer's frame and drawable size match the view's bounds.
        vividRenderLayer.frame = view.bounds
        vividRenderLayer.drawableSize = view.bounds.size
    }
}

extension GlowOverlayViewController {
    
    func setupVivid() {
        vividRenderLayer.device = MTLCreateSystemDefaultDevice()
        commandQueue = vividRenderLayer.device!.makeCommandQueue()
        defaultLibrary = vividRenderLayer.device!.makeDefaultLibrary()
        
        // Enable HDR content
        vividRenderLayer.setValue(NSNumber(booleanLiteral: true), forKey: "wantsExtendedDynamicRangeContent")
        
        vividRenderLayer.pixelFormat = .bgr10a2Unorm
        vividRenderLayer.colorspace = CGColorSpace(name: CGColorSpace.displayP3_PQ)
        vividRenderLayer.framebufferOnly = false // Change to false to allow content sampling
        vividRenderLayer.frame = self.view.bounds
        vividRenderLayer.backgroundColor = UIColor.clear.cgColor
        vividRenderLayer.isOpaque = false
        vividRenderLayer.drawableSize = self.view.frame.size
        
        // Change the blending mode to screen or add to brighten underlying content
        vividRenderLayer.compositingFilter = "multiplyBlendMode"

        vividRenderLayer.opacity = 1.0
        
        self.view.layer.insertSublayer(vividRenderLayer, at: 100)
        
        render()
    }
    
    @objc public func render() {
        guard let device = vividRenderLayer.device,
              let commandQueue = commandQueue else { return }
        
        let commandBuffer = commandQueue.makeCommandBuffer()
        commandBuffer?.label = "RenderFrameCommandBuffer"
        
        // Create a texture to sample the underlying content if needed
        // This part would require more complex Metal code to sample the view beneath
        
        let renderPassDescriptor = self.currentFrameBuffer()
        let renderEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        // Here you would set up a shader that enhances brightness
        // For now, we'll use a simple approach with a brighter clear color
        
        renderEncoder?.endEncoding()
        
        commandBuffer?.present(self.currentDrawable())
        commandBuffer?.commit()
        
        renderPass = nil
        drawable = nil
    }
    
    public func currentFrameBuffer() -> MTLRenderPassDescriptor {
        if (renderPass == nil) {
            let newDrawable = self.currentDrawable()
            
            renderPass = MTLRenderPassDescriptor()
            renderPass?.colorAttachments[0].texture = newDrawable.texture
            renderPass?.colorAttachments[0].loadAction = .clear

            
            // Use a much brighter color for HDR - these values can go beyond 1.0 for HDR
            // Using PQ color space, values like 3.0 or higher will appear very bright on HDR displays
            renderPass?.colorAttachments[0].clearColor = MTLClearColorMake(1.0, 1.0, 1.0, 0.5)
            
            
            renderPass?.colorAttachments[0].storeAction = .store
        }
        
        return renderPass!
    }
    
    public func currentDrawable() -> CAMetalDrawable {
        while (drawable == nil) {
            drawable = vividRenderLayer.nextDrawable()
        }
        
        return drawable!
    }
}

struct GlowRenderView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = GlowOverlayViewController
    
    func makeUIViewController(context: Context) -> GlowOverlayViewController {
        let controller = GlowOverlayViewController()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: GlowOverlayViewController, context: Context) {
        
    }
}

public extension View {
    /// Overlays the view with a glow effect.
    ///
    /// - Parameters:
    ///   - opacity: The opacity of the glow effect (default: `1.0`).
    /// - Returns: A view modified with a glow effect overlay.
    func glow(
        _ intensity: Double = 1.0
    ) -> some View {
        self.overlay {
            GlowRenderView()
                .blendMode(.multiply)
                .opacity(intensity)
        }
    }
}

// You cannot view this in regular previews or sim, you can use 'My Mac | Mac Catalyst', if your mac supports HDR to view it

#Preview {
    GlowGetterExampleView()
}

public struct GlowGetterExampleView: View {
    @State private var example1GlowIntensity = 0.4
    @State private var example2GlowIntensity = 0.6
    @State private var example3GlowIntensity = 0.8

    public init() {}

    public var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                Text(
                    "GlowGetter provides an easy-to-use SwiftUI modifier that overlays a view with a Metal-powered glow effect. With just one simple modifier, you can enhance your views with a subtle or pronounced glow to match your design needs. Under the hood, the package leverages a custom view (named GlowRenderView) that encapsulates Metal's powerful rendering functionalities."
                )
                .font(.caption2)
                .opacity(0.5)
                .padding(.top, 15)

                Divider()
                    .opacity(0.8)
                    .padding(.horizontal, 15)

                // Example 1: Rounded Rectangles
                VStack(spacing: 12) {
                    Text("Example 1")
                        .frame(maxWidth: .infinity, alignment: .leading)

                    HStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.orange)
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.orange)
                            .glow(example1GlowIntensity)
                            .clipShape(.rect(cornerRadius: 15))
                    }
                    .frame(height: 80)

                    Slider(value: $example1GlowIntensity, in: 0...1, step: 0.1)
                        .padding(.horizontal, 15)
                }
                .padding(.vertical, 8)

                // Example 2: Circles
                VStack(spacing: 12) {
                    Text("Example 2")
                        .frame(maxWidth: .infinity, alignment: .leading)

                    HStack {
                        Circle()
                            .fill(Color.red)
                        Circle()
                            .fill(Color.red)
                            .glow(example2GlowIntensity)
                            .clipShape(Circle())
                    }
                    .frame(height: 80)

                    Slider(value: $example2GlowIntensity, in: 0...1, step: 0.1)
                        .padding(.horizontal, 15)
                }
                .padding(.vertical, 8)

                // Example 3: Text Blocks
                VStack(spacing: 12) {
                    Text("Example 3")
                        .frame(maxWidth: .infinity, alignment: .leading)

                    VStack(spacing: 10) {
                        Text("Normal Text")
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .clipShape(.rect(cornerRadius: 15))

                        Text("Glowing Text")
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .glow(example3GlowIntensity)
                            .clipShape(.rect(cornerRadius: 15))
                    }

                    Slider(value: $example3GlowIntensity, in: 0...1, step: 0.1)
                        .padding(.horizontal, 15)
                }
                .padding(.vertical, 8)
            }
            .padding(.horizontal, 20)
        }
    }
}
