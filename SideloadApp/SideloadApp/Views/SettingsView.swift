import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var noteStore: NoteStore
    @State private var showDeleteAllConfirmation = false

    var body: some View {
        NavigationStack {
            List {
                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(.secondary)
                    }
                    HStack {
                        Text("Notes Count")
                        Spacer()
                        Text("\(noteStore.notes.count)")
                            .foregroundStyle(.secondary)
                    }
                }

                Section("Data") {
                    Button(role: .destructive) {
                        showDeleteAllConfirmation = true
                    } label: {
                        Label("Delete All Notes", systemImage: "trash")
                    }
                }

                Section("Info") {
                    Text("This app stores all notes locally on your device using UserDefaults. No data is sent to any server.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Settings")
            .alert("Delete All Notes?", isPresented: $showDeleteAllConfirmation) {
                Button("Delete All", role: .destructive) {
                    noteStore.notes.removeAll()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This will permanently delete all \(noteStore.notes.count) notes. This action cannot be undone.")
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(NoteStore())
}
