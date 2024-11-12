enum Status: Codable {
    case active
    case inactive(reason: String)
}

@Model class User {
    var name: String
    var age: Int
    var status: Status

    init(name: String, age: Int, status: Status) {
        self.name = name
        self.age = age
        self.status = status
    }
}
