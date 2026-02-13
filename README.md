# SideloadApp

A simple iOS notes app built with SwiftUI that you can sideload onto your iPhone or iPad.

## Features

- **Notes Management** - Create, edit, and delete notes
- **Pin Notes** - Pin important notes to the top
- **Search** - Find notes by title or content
- **Local Storage** - All data stored on-device via UserDefaults
- **Home Dashboard** - Quick overview with stats and recent notes

## Project Structure

```
SideloadApp/
├── SideloadApp.xcodeproj/
└── SideloadApp/
    ├── SideloadAppApp.swift      # App entry point
    ├── ContentView.swift          # Tab bar root view
    ├── Models/
    │   ├── Note.swift             # Note data model
    │   └── NoteStore.swift        # Note persistence & state
    └── Views/
        ├── HomeView.swift         # Home dashboard
        ├── NoteListView.swift     # Notes list + new note sheet
        ├── NoteDetailView.swift   # Note editor
        └── SettingsView.swift     # App settings
```

## How to Sideload onto Your iPhone

### Prerequisites

- A Mac with **Xcode 15+** installed (free from the Mac App Store)
- An **Apple ID** (free accounts work - no paid developer program needed)
- A **USB cable** to connect your iPhone to your Mac

### Steps

1. **Clone this repo** and open `SideloadApp/SideloadApp.xcodeproj` in Xcode.

2. **Sign in with your Apple ID** in Xcode:
   - Go to **Xcode > Settings > Accounts**
   - Click **+** and sign in with your Apple ID

3. **Set the signing team**:
   - Select the **SideloadApp** project in the navigator
   - Select the **SideloadApp** target
   - Go to the **Signing & Capabilities** tab
   - Check **Automatically manage signing**
   - Select your **Personal Team** from the Team dropdown
   - **Change the Bundle Identifier** to something unique, e.g. `com.yourname.SideloadApp`

4. **Connect your iPhone** via USB and select it as the run destination in the Xcode toolbar.

5. **Trust the developer profile** on your iPhone (first time only):
   - Go to **Settings > General > VPN & Device Management**
   - Tap your Apple ID under "Developer App"
   - Tap **Trust**

6. **Build and run** by pressing `Cmd + R` or clicking the Play button in Xcode.

### Notes on Free Sideloading

- Free Apple ID accounts let you install up to **3 apps** at a time
- Apps expire after **7 days** and need to be re-installed
- A paid Apple Developer account ($99/year) removes these limits
- The app must be re-signed each time from Xcode, or you can use tools like **AltStore** for automatic re-signing

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+
