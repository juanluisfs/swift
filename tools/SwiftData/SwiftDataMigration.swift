import Foundation
import SwiftData

enum DataSchemaV1: VersionedSchema {
    static var models: [any PersistentModel.Type] {
        [DataItem.self]
    }
    
    static var versionIdentifier: Schema.Version = .init(1, 0, 0)
}

extension DataSchemaV1 {
    @Model
    class DataItem: Identifiable {
        
        var id: String
        var name: String
        
        @Attribute(.externalStorage)
        var image: Data?
        
        init(name: String) {
            self.id = UUID().uuidString
            self.name = name
        }
    }
}

enum DataSchemaV2: VersionedSchema {
    static var models: [any PersistentModel.Type] {
        [DataItem.self]
    }
    
    static var versionIdentifier: Schema.Version = .init(1, 0, 1)
}

extension DataSchemaV2 {
    @Model
    class DataItem: Identifiable {
        
        var id: String
        var name: String
        var date: Date = Date.now
        
        @Attribute(.externalStorage)
        var image: Data?
        
        init(name: String, date: Date) {
            self.id = UUID().uuidString
            self.name = name
            self.date = date
        }
    }
}

enum DataSchemaV3: VersionedSchema {
    static var models: [any PersistentModel.Type] {
        [DataItem.self]
    }
    
    static var versionIdentifier: Schema.Version = .init(1, 0, 2)
}

extension DataSchemaV3 {
    @Model
    class DataItem: Identifiable {
        
        var id: String
        var name: String
        var date: Date
        var text: String = ""
        
        @Attribute(.externalStorage)
        var image: Data?
        
        init(name: String, date: Date, text: String) {
            self.id = UUID().uuidString
            self.name = name
            self.date = date
            self.text = text
        }
    }
}

import SwiftUI
import SwiftData

typealias DataItem = DataSchemaV3.DataItem

enum DataItemMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [
            DataSchemaV1.self,
            DataSchemaV2.self,
            DataSchemaV3.self
        ]
    }
    
    static var stages: [MigrationStage] {
        [
            migrateV1toV2,
            migrateV2toV3
        ]
    }
    
    static let migrateV1toV2 = MigrationStage.custom(
        fromVersion: DataSchemaV1.self,
        toVersion: DataSchemaV2.self,
        willMigrate: { _ in },
        didMigrate: { context in
            do {
                let items = try context.fetch(FetchDescriptor<DataSchemaV2.DataItem>())
                for item in items {
                    item.date = Date.now
                }
                try context.save()
            } catch {
                print("Migration error in didMigrate: \(error)")
            }
        }
    )
    
    static let migrateV2toV3 = MigrationStage.custom(
        fromVersion: DataSchemaV2.self,
        toVersion: DataSchemaV3.self,
        willMigrate: { _ in },
        didMigrate: { context in
            do {
                let items = try context.fetch(FetchDescriptor<DataSchemaV3.DataItem>())
                for item in items {
                    item.text = "Updated"
                }
                try context.save()
            } catch {
                print("Migration error in didMigrate: \(error)")
            }
        }
    )
}

@main
struct SwiftDataDemoApp: App {
    
    private let modelContainer: ModelContainer?
    
    init() {
        do {
            let schema = Schema([
                DataItem.self
            ])
            
            let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: false)
            
            modelContainer = try ModelContainer(
                for: schema,
                migrationPlan: DataItemMigrationPlan.self,
                configurations: modelConfiguration
            )
        } catch {
            print("Failed to create ModelContainer: \(error)")
            modelContainer = nil
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if let container = modelContainer {
                ContentView()
                    .modelContainer(container)
            } else {
                ErrorView(message: "Failed to initialize database")
            }
        }
    }
}

struct ErrorView: View {
    let message: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 60))
                .foregroundColor(.red)
            
            Text("Database Error")
                .font(.title)
                .fontWeight(.bold)
            
            Text(message)
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Clear App Data & Restart") {
                // Clear UserDefaults
                if let bundleID = Bundle.main.bundleIdentifier {
                    UserDefaults.standard.removePersistentDomain(forName: bundleID)
                }
                
                // Try to delete the database file
                let applicationSupportURL = FileManager.default.urls(
                    for: .applicationSupportDirectory,
                    in: .userDomainMask
                ).first!
                let storeURL = applicationSupportURL.appending(path: "default.store")
                
                do {
                    if FileManager.default.fileExists(atPath: storeURL.path) {
                        try FileManager.default.removeItem(at: storeURL)
                    }
                } catch {
                    print("Failed to delete database: \(error)")
                }
                
                // Restart the app
                exit(0)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}
