import SwiftUI

@main
struct SideloadAppApp: App {
    @StateObject private var noteStore = NoteStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(noteStore)
        }
    }
}
