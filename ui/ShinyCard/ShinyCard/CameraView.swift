//
//  CameraView.swift
//  ShinyCard
//
//  Created by Meng To on 2023-03-04.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        let viewController = UIViewControllerType()
        viewController.delegate = context.coordinator
        viewController.sourceType = .camera
        viewController.cameraDevice = .front
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    func makeCoordinator() -> CameraView.Coordinator {
        return Coordinator(self)
    }
}

extension CameraView {
    class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
    }
}
