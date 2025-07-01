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
