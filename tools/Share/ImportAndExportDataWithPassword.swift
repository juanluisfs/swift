//
//  ImportAndExportSwiftDataApp.swift
//  ImportAndExportSwiftData
//
//  Created by Juan Luis on 17/03/25.
//

import SwiftUI

@main
struct ImportAndExportSwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Transaction.self)
        }
    }
}

import CryptoKit
import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Query(sort: [.init(\Transaction.transactionDate, order: .reverse)], animation: .snappy)
    
    private var transactions: [Transaction]
    
    @Environment(\.modelContext) private var context
    
    // View Properties
    @State private var showAlertTF: Bool = false
    @State private var keyTF: String = ""
    
    // Exporter Properties
    @State private var exportItem: TransactionTransferable?
    @State private var showFileExporter: Bool = false
    
    // importer Properties
    @State private var showFileImporter: Bool = false
    @State private var importedURL: URL?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(transactions) {
                    Text($0.transactionName)
                }
            }
            .navigationTitle("Transactions")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAlertTF.toggle()
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showFileImporter.toggle()
                    } label: {
                        Image(systemName: "square.and.arrow.down")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // DummyData
                        let transaction  = Transaction(
                            transactionName: "Dummy Transaction",
                            transactionDate: .now,
                            transactionAmount: 1299.89,
                            transactionCategory: .expense)
                        
                        context.insert(transaction)
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }

                }
            }
        }
        .alert("Enter key", isPresented: $showAlertTF) {
            TextField("Key", text: $keyTF)
                .autocorrectionDisabled()
                .privacySensitive()
            
            Button("Cancel", role: .cancel) {
                keyTF = ""
                importedURL = nil
            }
            
            Button(importedURL != nil ? "Import":"Export") {
                if importedURL != nil {
                    importData()
                } else {
                    exportData()
                }
            }
        }
        .fileExporter(isPresented: $showFileExporter, item: exportItem, contentTypes: [.data], defaultFilename: "Transactions") { result in
            switch result {
            case .success(_):
                print("Success")
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            exportItem = nil
        } onCancellation: {
            exportItem = nil
        }
        .fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.data]) { result in
            switch result {
            case .success(let url):
                importedURL = url
                showAlertTF.toggle()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func exportData() {
        Task.detached(priority: .background) {
            do {
                let container = try ModelContainer(for: Transaction.self)
                let context = ModelContext(container)
                
                let descriptor = FetchDescriptor(sortBy: [
                    .init(\Transaction.transactionDate, order: .reverse)
                ])
                
                let allObjects = try context.fetch(descriptor)
                let exportItem = await TransactionTransferable(transactions: allObjects, key: keyTF)
                
                await MainActor.run {
                    self.exportItem = exportItem
                    showFileExporter = true
                    keyTF = ""
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func importData() {
        guard let url = importedURL else { return }
        Task.detached(priority: .background) {
            do {
                guard url.startAccessingSecurityScopedResource() else { return }
                
                let container =  try ModelContainer(for: Transaction.self)
                let context = ModelContext(container)
                
                let encryptedData = try Data(contentsOf: url)
                let decryptedData = try await AES.GCM.open(.init(combined: encryptedData), using: .key(keyTF))
                
                let allTransactions = try JSONDecoder().decode([Transaction].self, from: decryptedData)
                
                for transaction in allTransactions {
                    context.insert(transaction)
                }
                
                try context.save()
                
                url.stopAccessingSecurityScopedResource()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

@Model
class Transaction: Codable {
    var transactionName: String
    var transactionDate: Date
    var transactionAmount: Double
    var transactionCategory: TransactionCategory
    
    init(transactionName: String, transactionDate: Date, transactionAmount: Double, transactionCategory: TransactionCategory) {
        self.transactionName = transactionName
        self.transactionDate = transactionDate
        self.transactionAmount = transactionAmount
        self.transactionCategory = transactionCategory
    }
    
    enum CodingKeys: CodingKey {
        case transactionName
        case transactionDate
        case transactionAmount
        case transactionCategory
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        transactionName = try container.decode(String.self, forKey: .transactionName)
        transactionDate = try container.decode(Date.self, forKey: .transactionDate)
        transactionAmount = try container.decode(Double.self, forKey: .transactionAmount)
        transactionCategory = try container.decode(TransactionCategory.self, forKey: .transactionCategory)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(transactionName, forKey: .transactionName)
        try container.encode(transactionDate, forKey: .transactionDate)
        try container.encode(transactionAmount, forKey: .transactionAmount)
        try container.encode(transactionCategory, forKey: .transactionCategory)
    }
}

struct TransactionTransferable: Transferable {
    
    var transactions: [Transaction]
    var key: String
    
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(exportedContentType: .data) {
            let data = try JSONEncoder().encode($0.transactions)
            guard let encryptedData = try AES.GCM.seal(data, using: .key($0.key)).combined else {
                throw EncryptionError.encryptionFailed
            }
            
            return encryptedData
        }
    }
    
    enum EncryptionError: Error {
        case encryptionFailed
    }
}

extension SymmetricKey {
    static func key(_ value: String) -> SymmetricKey {
        let keyData = value.data(using: .utf8)!
        let sha256 = SHA256.hash(data: keyData)
        
        return .init(data: sha256)
    }
}

enum TransactionCategory: String, Codable {
    case income = "Income"
    case expense = "Expense"
}

#Preview {
    ContentView()
        .modelContainer(for: Transaction.self)
}
