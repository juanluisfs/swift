import Foundation
import SwiftUI

struct Constants {
    static let dotsPerInch: CGFloat = 72.0
    static let pageWidth: CGFloat = 8.5
    static let pageHeight: CGFloat = 11.0
}

struct PDFInfo {
    let title: String
    let image: Image
    let description: String
}

import SwiftUI

struct PDFView: View {
    
    let info: PDFInfo
    
    var body: some View {
        VStack {
            Text(info.title)
                .font(.title)
                .padding(.vertical, 25)
            
            info.image
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 50)
            
            Text(info.description)
                .multilineTextAlignment(.center)
                .padding(.vertical, 25)
                .padding(.horizontal, 40)
        }
        .frame(width: Constants.pageWidth * Constants.dotsPerInch, height: Constants.pageHeight * Constants.dotsPerInch)
    }
}

import Foundation
import PDFKit
import SwiftUI

class PDFCreator {
    let multiplePages: [PDFInfo]
    
    private let metaData = [
        kCGPDFContextAuthor: "Juan Luis Flores",
        kCGPDFContextSubject: "This is a demo on how to create a PDF from a Swift app"
    ]
    
    private var rect: CGRect {
        return CGRect(x: 0, y: 0, width: Constants.pageWidth * Constants.dotsPerInch, height: Constants.pageHeight * Constants.dotsPerInch)
    }
    
    init(multiplePages: [PDFInfo]) {
        self.multiplePages = multiplePages
    }
    
    @MainActor
    func createPDFData(displayScale: CGFloat) -> URL {
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = metaData as [String : Any]
        let renderer = UIGraphicsPDFRenderer(bounds: rect, format: format)
        
        let tempFolder = FileManager.default.temporaryDirectory
        let fileName = "My Custom PDF title.pdf"
        let tempURL = tempFolder.appendingPathComponent(fileName)
        
        try? renderer.writePDF(to: tempURL) { context in
            for info in multiplePages {
                context.beginPage()
                let imageRenderer = ImageRenderer(content: PDFView(info: info))
                imageRenderer.scale = displayScale
                imageRenderer.uiImage?.draw(at: CGPoint.zero)
            }
        }
        
        return tempURL
    }
}

import SwiftUI

struct SharePDFView: View {
    
    @Environment(\.displayScale) var displayScale
    @State private var exportPDF: Bool = false
    
    let pdfCreator = PDFCreator(multiplePages: [
        PDFInfo(title: "Page 1", image: Image("1"), description: "Page 1"),
        PDFInfo(title: "Page 2", image: Image("2"), description: "Page 2"),
        PDFInfo(title: "Page 3", image: Image("3"), description: "Page 3")
    ])
    
    var body: some View {
        VStack {
            ShareLink(item: pdfCreator.createPDFData(displayScale: displayScale))
                .padding()
        }
    }
}

#Preview {
    SharePDFView()
}
