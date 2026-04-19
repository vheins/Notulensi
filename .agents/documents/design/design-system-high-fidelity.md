# Design System Implementation: The Obsidian Archive

This document defines the high-fidelity implementation of the **Obsidian Archive** design system, generated and verified via Google Stitch.

## 1. Core Palette (Stitch Verified)
- **Background**: `#000000` (Pure Black)
- **Surface**: `#1C1C1E` (Dark Charcoal)
- **Primary**: `#0A84FF` (Safe-Box Blue)
- **Secondary**: `#30D158` (Intelligence Green)
- **Error/Pulse**: `#FF453A` (Redaction Red)

## 2. Typography
- **Headings**: `Geist` / `Space Grotesk` (Modern Geometric)
- **Body/Metadata**: `IBM Plex Sans` (Technical Utility)
- **Monospace**: `IBM Plex Mono` (Timestamps/Durations)

## 3. High-Fidelity Screen References (Project 10497226523893204507)

### Core Pages
- **Security Gate (Auth Splash)**: [Screen 1db1e787ee9449b7a4e066536b486933]
  - Visuals: Central Obsidian Vault icon, Biometric unlock button.
- **Home Dashboard**: [Screen ed1314d67c7447ada73cedf096b398c2]
  - Features: Search Bar, Insights Ribbon, Folder Chips, Note Cards.
- **Folder Detail**: [Screen c8393407595544eda31772b7bc180e66]
  - Features: Filtered list, Sort dropdown, Folder title.
- **Active Recording**: [Screen 42ea8fa6f52b4e76b9c39e11306da23f]
  - Features: Pulsing red timer, Fade-in live transcript, Dynamic waveform, Primary FAB Stop button.
- **Note Detail**: [Screen 7a2a329bbb2540ae825eb7278d4d9eb7]
  - Features: Audio Player Card, Inline timestamped photos, Intelligence highlights.
- **Settings & Storage**: [Screen 1227fcf3ddf44829b8771c197c48314c]
  - Features: Categorized sections, Donut Chart for storage, Rewarded Ad Card.

### Overlays & Modals
- **Export & Versions Overlay**: [Screen 9f4e59819447429da9af91e864a4f59a]
  - Features: Glassmorphism Bottom Sheet, Action icons for PDF/QR/History.

## 4. Interaction Guidelines
- **Tonal Shifts**: Use `#1C1C1E` against `#000000` to define card boundaries (The "No-Line" Rule).
- **Glassmorphism**: Modals and Bottom Sheets use 80% opacity with 24px backdrop blur.
- **Haptics**: Medium impact for FABs, Light for Markers.
