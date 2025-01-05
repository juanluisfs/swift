//
//  SignatureView.swift
//  GenerateCSV
//
//  Created by Juan Luis on 04/01/25.
//

import Foundation
import SwiftUI

struct SignatureView: View {
    
    @State private var strokes: [[CGPoint]] = []
    @State private var undoneStrokes: [[CGPoint]] = []
    
    @State private var currentStroke: [CGPoint] = []
    
    @State private var capturedImage: Image? = nil
    
    @State private var isDrawingComplete = false
    
    @State private var lineColor: Color = .blue
    
    @State private var lineWidth: CGFloat = 2.0
    
    @State private var addWatermark: Bool = true
    
    @State private var padFrame: CGRect = .zero
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    VStack(spacing: 5) {
                        Text("Signature Capture")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundStyle(.blue)
                        
                        Text("Sign below and adjust the stroke settings as needed")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                    .padding(.top, 20)
                    
                    ZStack {
                        GeometryReader { geometry in
                            RoundedRectangle(cornerRadius: 20)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.05)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                }
                                .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 5)
                                .onAppear {
                                    padFrame = geometry.frame(in: .local)
                                }
                            
                            ZStack {
                                ForEach(strokes, id: \.self) { stroke in
                                    Path { path in
                                        guard let firstPoint = stroke.first else { return }
                                        path.move(to: firstPoint)
                                        for point in stroke.dropFirst() {
                                            path.addLine(to: point)
                                        }
                                    }
                                    .stroke(lineColor, lineWidth: lineWidth)
                                }
                                
                                Path { path in
                                    guard let firstPoint = currentStroke.first else { return }
                                    path.move(to: firstPoint)
                                    for point in currentStroke.dropFirst() {
                                        path.addLine(to: point)
                                    }
                                }
                                .stroke(lineColor, lineWidth: lineWidth)
                            }
                            
                            if strokes.isEmpty && currentStroke.isEmpty {
                                Text("Draw your signature here")
                                    .foregroundStyle(.gray)
                                    .italic()
                                    .transition(.opacity)
                                    .padding()
                            }
                        }
                        .frame(height: 300)
                        .padding()
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    let location = value.location
                                    if padFrame.contains(location) {
                                        currentStroke.append(location)
                                    }
                                }
                                .onEnded { _ in
                                    if !currentStroke.isEmpty {
                                        strokes.append(currentStroke)
                                        currentStroke.removeAll()
                                        undoneStrokes.removeAll()
                                    }
                                }
                        )
                    }
                    
                    HStack(spacing: 20) {
                        VStack {
                            Text("Line Color")
                                .font(.caption)
                            
                            ColorPicker("", selection: $lineColor)
                                .labelsHidden()
                                .scaleEffect(1.2)
                        }
                        
                        VStack {
                            Text("Line Width")
                                .font(.caption)
                            
                            Slider(value: $lineWidth, in: 1...10)
                                .frame(width: 100)
                        }
                        
                        VStack {
                            Text("Watermark")
                                .font(.caption)
                            
                            Toggle("", isOn: $addWatermark)
                                .labelsHidden()
                                .scaleEffect(1.2)
                        }
                    }
                    .padding(.vertical, 10)
                    
                    HStack(spacing: 20) {
                        Button {
                            undoLastStroke()
                        } label: {
                            Text("Undo")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding()
                                .frame(width: 80)
                                .background(Color.orange)
                                .shadow(color: Color.orange.opacity(0.6), radius: 5, x: 0, y: 5)
                        }
                        
                        Button {
                            redoLastStrokes()
                        } label: {
                            Text("Redo")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding()
                                .frame(width: 80)
                                .background(Color.purple)
                                .shadow(color: Color.orange.opacity(0.6), radius: 5, x: 0, y: 5)
                        }
                        
                        Button {
                            clearSignature()
                        } label: {
                            Text("Clear")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding()
                                .frame(width: 80)
                                .background(Color.red)
                                .shadow(color: Color.orange.opacity(0.6), radius: 5, x: 0, y: 5)
                        }
                        
                        Button {
                            isDrawingComplete = true
                            captureSignatire()
                        } label: {
                            Text("Done")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding()
                                .frame(width: 80)
                                .background(Color.green)
                                .shadow(color: Color.orange.opacity(0.6), radius: 5, x: 0, y: 5)
                        }
                    }
                    
                    if let image = capturedImage, isDrawingComplete {
                        Text("Your signature:")
                            .font(.headline)
                            .padding(.top, 10)
                        
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .border(Color.gray, width: 1)
                            .padding()
                        
                    }
                }
            }
        }
    }
    
    func captureSignatire() {
        let renderer = ImageRenderer(content: ZStack {
            Color.white.frame(width: 300, height: 300)
            
            ForEach(strokes, id: \.self) { stroke in
                Path { path in
                    guard let firstPoint = stroke.first else { return }
                    path.move(to: firstPoint)
                    for point in stroke.dropFirst() {
                        path.addLine(to: point)
                    }
                }
                .stroke(lineColor, lineWidth: lineWidth)
            }
            
            if addWatermark {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("Signature")
                            .font(.caption2)
                            .foregroundStyle(.gray)
                            .padding(4)
                            .background(Color.white.opacity(0.7))
                            .padding()
                    }
                }
            }
        })
        
        if let uiImage = renderer.uiImage {
            capturedImage = Image(uiImage: uiImage)
        }
    }
    
    func uiImageFromImage(image: Image) -> UIImage? {
        let controller = UIHostingController(rootView: image)
        let view = controller.view
        let targetSize = CGSize(width: 300, height: 300)
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
        }
    }
    
    func undoLastStroke() {
        guard let last = undoneStrokes.popLast() else { return }
        undoneStrokes.append(last)
    }
    
    func redoLastStrokes() {
        guard let last = undoneStrokes.popLast() else { return }
        strokes.append(last)
    }
    
    func clearSignature() {
        strokes.removeAll()
        undoneStrokes.removeAll()
        currentStroke.removeAll()
        capturedImage = nil
        isDrawingComplete = false
    }
}

#Preview {
    SignatureView()
}
