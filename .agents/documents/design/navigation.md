# Navigation Structure Design: Notulensi

## 1. App Info
- **App Name**: Notulensi
- **Type**: Mobile App (Flutter)
- **User Roles**: Single User (Local, Privacy-First)
- **Key Features**: Offline Recording, Rule-Based Extraction, Encrypted Storage, Multi-format Export.
- **Platform**: Android & iOS

## 2. Navigation Pattern
- **Primary Pattern**: Bottom Tab Bar (Home, Folders, Settings).
- **Secondary Pattern**: Stack Navigation (Push/Pop) for detailed views (Note Details, Recording Active).
- **Contextual**: Floating Action Button (FAB) prominently centered or elevated for quick recording access.
- **Security Gate**: Biometric prompt blocks initial access to the root navigator if Safe-Box is enabled.

## 3. Route Tree
```text
Root (Biometric Gate)
├── Tabs
│   ├── Home (Dashboard)
│   │   ├── Search overlay
│   │   └── Note Detail
│   │       ├── Export Bottom Sheet
│   │       ├── Version History Sheet
│   │       └── Photo Gallery Modal
│   ├── Folders
│   │   └── Folder Detail
│   │       └── Note Detail (Shared Route)
│   └── Settings
│       ├── Storage Dashboard
│       ├── AdMob/Pro Upgrade
│       └── STT Model Status
└── Modals
    └── Active Recording (Fullscreen Modal)
```

## 4. Component Recommendations
- **Navigation Bar**: Flutter `BottomNavigationBar` (or `NavigationBar` for Material 3).
- **Recording Modal**: A full-screen `showGeneralDialog` or a pushed route without a back button (to prevent accidental closing without explicit 'Stop' or 'Cancel').
- **Detail Screens**: `CustomScrollView` with `SliverAppBar` to allow the title to collapse as the user scrolls through long transcripts.
- **Markers**: A horizontal scrolling timeline or discrete chips above the transcript in the Note Detail view.

## 5. Route Table
| Route Path | Page Name | Access Level | Nav Component | Notes |
|---|---|---|---|---|
| `/` | Splash/Auth | System | None | Checks Biometrics before redirecting. |
| `/home` | Dashboard | User | Bottom Tab (1) | Displays recent notes and global search. |
| `/folders` | Folders | User | Bottom Tab (2) | Manages project/client groupings. |
| `/settings` | Settings | User | Bottom Tab (3) | Storage, STT models, Pro upgrade. |
| `/recording` | Active Recording | User | Fullscreen Modal | Triggered via FAB from any Tab. Blocks back navigation. |
| `/note/:id` | Note Detail | User | Push (Stack) | Shared view accessed from Home or Folders. Contains Export/Delete actions. |
| `/folder/:id` | Folder Detail | User | Push (Stack) | Filtered view of notes within a specific folder. |
