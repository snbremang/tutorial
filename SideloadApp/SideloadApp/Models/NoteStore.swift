import Foundation

class NoteStore: ObservableObject {
    @Published var notes: [Note] = [] {
        didSet { save() }
    }

    private let saveKey = "SavedNotes"

    init() {
        load()
    }

    func add(_ note: Note) {
        notes.insert(note, at: 0)
    }

    func update(_ note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            var updated = note
            updated.updatedAt = Date()
            notes[index] = updated
        }
    }

    func delete(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
    }

    func delete(_ note: Note) {
        notes.removeAll { $0.id == note.id }
    }

    func togglePin(_ note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].isPinned.toggle()
        }
    }

    var pinnedNotes: [Note] {
        notes.filter { $0.isPinned }.sorted { $0.updatedAt > $1.updatedAt }
    }

    var unpinnedNotes: [Note] {
        notes.filter { !$0.isPinned }.sorted { $0.updatedAt > $1.updatedAt }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Note].self, from: data) {
            notes = decoded
        }
    }
}
