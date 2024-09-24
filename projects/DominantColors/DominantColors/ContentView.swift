//
//  ContentView.swift
//  DominantColors
//
//  Created by Juan Luis on 23/09/24.
//

import PhotosUI
import SwiftUI

struct ContentView: View {
    
    @State var uiImage: UIImage?
    @State var selectedPhoto: PhotosPickerItem?
    
    @State var mainColor: Color?
    @State var mainColors: [Color] = []
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $selectedPhoto, matching: .images, photoLibrary: .shared()) {
                Label("Photo", systemImage: "photo.on.rectangle.angled")
                    .fontWeight(.bold)
                    .frame(width: 84, height: 40)
                    .labelStyle(.titleAndIcon)
            }
            .task(id: selectedPhoto) {
                if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                    uiImage = UIImage(data: data)
                    mainColor = nil
                    mainColors.removeAll()
                }
            }
            
            if uiImage != nil {
                Image(uiImage: uiImage!)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                Button("Calculate") {
                    let imageResize = uiImage?.resized(to: CGSize(width: 300, height: 300))
                    let kMeans = KMeansClusterer()
                    let points = imageResize!.getPixels().map({KMeansClusterer.Point(from: $0)})
                    let clusters = kMeans.cluster(points: points, into: 10).sorted(by: {$0.points.count > $1.points.count})
                    let colors = clusters.map(({$0.center.toUIColor()}))
                    mainColor = Color(uiColor: colors.first!)
                    for color in colors {
                        if mainColors.count < 10 {
                            mainColors.append(Color(uiColor: color))
                        }
                    }
                }
            }
            
            if mainColor != nil {
                Rectangle()
                    .foregroundStyle(mainColor!)
                    .frame(width: 50, height: 50)
            }
            
            if !mainColors.isEmpty {
                ScrollView(.horizontal) {
                    HStack {
                        let top = mainColors.count
                        ForEach(0..<10) { i in
                            Rectangle()
                                .foregroundStyle(mainColors[i])
                                .frame(width: 50, height: 50)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
