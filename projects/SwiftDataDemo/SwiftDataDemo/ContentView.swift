//
//  ContentView.swift
//  SwiftDataDemo
//
//  Created by Juan Luis on 10/05/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    
    @Query private var items: [DataItem]
    
    @State var selectedPhoto: PhotosPickerItem?
    
    var body: some View {
        VStack {
            Button {
                addItem()
            } label: {
                Text("Add an Item")
            }
            
            List {
                ForEach(items) { item in
                    VStack {
                        HStack {
                            Text(item.name)
                            Spacer()
                            PhotosPicker(selection: $selectedPhoto, matching: .images, photoLibrary: .shared()) {
                                Label("Image", systemImage: "photo")
                            }
                            Spacer()
                            Button {
                                updateItem(item)
                            } label: {
                                Image(systemName: "arrow.triangle.2.circlepath")
                            }
                        }
                        
                        if let imageData = item.image, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 300)
                        }
                        
                        if item.image != nil {
                            Button(role: .destructive) {
                                withAnimation {
                                    selectedPhoto = nil
                                    item.image = nil
                                }
                            } label: {
                                Label("Remove", systemImage: "xmark")
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                    .task(id: selectedPhoto) {
                        if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                            item.image = data
                        }
                    }
                }
                .onDelete { indexes in
                    for index in indexes {
                        deleteItem(items[index])
                    }
                }
            }
        }
        .padding()
    }
    
    func addItem() {
        // Create the item
        let item = DataItem(name: "Prueba")
        //Add the item
        context.insert(item)
    }
    
    func deleteItem(_ item: DataItem) {
        context.delete(item)
    }
    
    func updateItem(_ item: DataItem) {
        // Edite the item Data
        item.name = "Updated Test Item"
        try? context.save()
    }
}
