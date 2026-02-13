import Foundation

struct Note: Identifiable, Codable, Equatable {
    var id: UUID
    var title: String
    var content: String
    var createdAt: Date
    var updatedAt: Date
    var isPinned: Bool

    init(id: UUID = UUID(), title: String = "", content: String = "", isPinned: Bool = false) {
        self.id = id
        self.title = title
        self.content = content
        self.createdAt = Date()
        self.updatedAt = Date()
        self.isPinned = isPinned
    }
}
