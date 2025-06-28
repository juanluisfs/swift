Button {
                            presentImporter = true
                        } label: {
                            Image(systemName: "document.on.document")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(primaryColor())
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundStyle(primaryColor().opacity(0.25))
                                )
                        }
                        .fileImporter(isPresented: $presentImporter, allowedContentTypes: [.pdf]) { result in
                            switch result {
                            case .success(let url):
                                print(url)
                                //use `url.startAccessingSecurityScopedResource()` if you are going to read the data
                                let accessGranted = url.startAccessingSecurityScopedResource()
                                
                                if accessGranted {
                                    selectedImages = convertPDFToImages(pdfURL: url)!
                                    url.stopAccessingSecurityScopedResource()
                                } else {
                                    print("Failed to obtain access to the security-scoped resource.")
                                }
                            case .failure(let error):
                                print(error)
                            }
                        }
