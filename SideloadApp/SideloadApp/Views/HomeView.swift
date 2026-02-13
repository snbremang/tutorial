import SwiftUI

struct HomeView: View {
    @EnvironmentObject var noteStore: NoteStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Welcome card
                    VStack(spacing: 12) {
                        Image(systemName: "app.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(.blue.gradient)

                        Text("SideloadApp")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("Your personal notes, always with you.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 30)

                    // Stats
                    HStack(spacing: 16) {
                        StatCard(
                            title: "Total Notes",
                            value: "\(noteStore.notes.count)",
                            icon: "doc.text.fill",
                            color: .blue
                        )
                        StatCard(
                            title: "Pinned",
                            value: "\(noteStore.pinnedNotes.count)",
                            icon: "pin.fill",
                            color: .orange
                        )
                    }
                    .padding(.horizontal)

                    // Recent notes
                    if !noteStore.notes.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Recent Notes")
                                .font(.headline)
                                .padding(.horizontal)

                            ForEach(noteStore.notes.prefix(3)) { note in
                                RecentNoteRow(note: note)
                                    .padding(.horizontal)
                            }
                        }
                    } else {
                        VStack(spacing: 12) {
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 40))
                                .foregroundStyle(.secondary)

                            Text("No notes yet")
                                .font(.headline)
                                .foregroundStyle(.secondary)

                            Text("Head over to the Notes tab to create your first note.")
                                .font(.subheadline)
                                .foregroundStyle(.tertiary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.vertical, 30)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Home")
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)

            Text(value)
                .font(.title)
                .fontWeight(.bold)

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct RecentNoteRow: View {
    let note: Note

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(note.title.isEmpty ? "Untitled" : note.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(1)

                Spacer()

                if note.isPinned {
                    Image(systemName: "pin.fill")
                        .font(.caption)
                        .foregroundStyle(.orange)
                }
            }

            Text(note.content.isEmpty ? "No content" : note.content)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(2)

            Text(note.updatedAt.formatted(date: .abbreviated, time: .shortened))
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    HomeView()
        .environmentObject(NoteStore())
}
