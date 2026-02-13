import SwiftUI

struct NoteDetailView: View {
    @EnvironmentObject var noteStore: NoteStore
    @Environment(\.dismiss) private var dismiss

    let note: Note
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var showDeleteConfirmation = false

    var body: some View {
        Form {
            TextField("Title", text: $title)
                .font(.headline)

            Section("Content") {
                TextEditor(text: $content)
                    .frame(minHeight: 300)
            }

            Section {
                HStack {
                    Text("Created")
                    Spacer()
                    Text(note.createdAt.formatted(date: .long, time: .shortened))
                        .foregroundStyle(.secondary)
                }
                HStack {
                    Text("Updated")
                    Spacer()
                    Text(note.updatedAt.formatted(date: .long, time: .shortened))
                        .foregroundStyle(.secondary)
                }
            }

            Section {
                Button(role: .destructive) {
                    showDeleteConfirmation = true
                } label: {
                    Label("Delete Note", systemImage: "trash")
                }
            }
        }
        .navigationTitle("Edit Note")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    noteStore.togglePin(note)
                } label: {
                    Image(systemName: note.isPinned ? "pin.slash" : "pin")
                }
            }
        }
        .onAppear {
            title = note.title
            content = note.content
        }
        .onDisappear {
            if title != note.title || content != note.content {
                var updated = note
                updated.title = title
                updated.content = content
                noteStore.update(updated)
            }
        }
        .alert("Delete Note?", isPresented: $showDeleteConfirmation) {
            Button("Delete", role: .destructive) {
                noteStore.delete(note)
                dismiss()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This action cannot be undone.")
        }
    }
}

#Preview {
    NavigationStack {
        NoteDetailView(note: Note(title: "Sample", content: "This is a sample note."))
            .environmentObject(NoteStore())
    }
}
