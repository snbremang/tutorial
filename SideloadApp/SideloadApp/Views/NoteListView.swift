import SwiftUI

struct NoteListView: View {
    @EnvironmentObject var noteStore: NoteStore
    @State private var showingNewNote = false
    @State private var searchText = ""

    var filteredPinned: [Note] {
        if searchText.isEmpty { return noteStore.pinnedNotes }
        return noteStore.pinnedNotes.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.content.localizedCaseInsensitiveContains(searchText)
        }
    }

    var filteredUnpinned: [Note] {
        if searchText.isEmpty { return noteStore.unpinnedNotes }
        return noteStore.unpinnedNotes.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.content.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                if !filteredPinned.isEmpty {
                    Section("Pinned") {
                        ForEach(filteredPinned) { note in
                            NavigationLink(destination: NoteDetailView(note: note)) {
                                NoteRow(note: note)
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    noteStore.delete(note)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    noteStore.togglePin(note)
                                } label: {
                                    Label("Unpin", systemImage: "pin.slash")
                                }
                                .tint(.orange)
                            }
                        }
                    }
                }

                Section(filteredPinned.isEmpty ? "Notes" : "Other") {
                    ForEach(filteredUnpinned) { note in
                        NavigationLink(destination: NoteDetailView(note: note)) {
                            NoteRow(note: note)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                noteStore.delete(note)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                noteStore.togglePin(note)
                            } label: {
                                Label("Pin", systemImage: "pin")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
            .overlay {
                if noteStore.notes.isEmpty {
                    ContentUnavailableView {
                        Label("No Notes", systemImage: "note.text")
                    } description: {
                        Text("Tap the + button to create a new note.")
                    }
                }
            }
            .navigationTitle("Notes")
            .searchable(text: $searchText, prompt: "Search notes")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingNewNote = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingNewNote) {
                NewNoteView()
            }
        }
    }
}

struct NoteRow: View {
    let note: Note

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(note.title.isEmpty ? "Untitled" : note.title)
                .font(.body)
                .fontWeight(.medium)
                .lineLimit(1)

            Text(note.content.isEmpty ? "No content" : note.content)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)

            Text(note.updatedAt.formatted(date: .abbreviated, time: .shortened))
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 2)
    }
}

struct NewNoteView: View {
    @EnvironmentObject var noteStore: NoteStore
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var content = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                    .font(.headline)

                Section("Content") {
                    TextEditor(text: $content)
                        .frame(minHeight: 200)
                }
            }
            .navigationTitle("New Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let note = Note(title: title, content: content)
                        noteStore.add(note)
                        dismiss()
                    }
                    .disabled(title.isEmpty && content.isEmpty)
                }
            }
        }
    }
}

#Preview {
    NoteListView()
        .environmentObject(NoteStore())
}
