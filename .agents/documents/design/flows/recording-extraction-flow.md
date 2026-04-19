# User Flow Diagram Description: Notulensi Core Recording & Extraction

## 1. Flow Overview
- **Flow Name**: Audio Recording & Intelligent Extraction
- **User Goal**: Capture a meeting securely, view live transcription, and receive structured action items/deadlines immediately upon completion without internet access.
- **Starting Point**: Home Screen (Dashboard) -> Tap 'Record' FAB.
- **Tech Context**: Flutter, Isar (Encrypted), `record` package, `speech_to_text`, Dart Isolates for Regex parsing.
- **Errors Included**: Yes (Permissions, Storage, STT Model).

## 2. Node List
| ID | Type | Label | Description |
|---|---|---|---|
| N1 | Screen | Home Dashboard | Main screen displaying existing notes and the 'Record' FAB. |
| N2 | Action | Tap Record FAB | User initiates a recording session. |
| N3 | Condition | Permission Check | System verifies microphone permission. |
| N4 | State | Permission Request | OS dialog asking for mic access. |
| N5 | Condition | STT Model Check | System checks if the offline STT model is ready. |
| N6 | State | Model Download Prompt | Dialog guiding user to OS settings to download the language pack. |
| N7 | Screen | Recording Screen | Active recording UI with duration, waveform, and live transcript. |
| N8 | Action | Drop Marker | User taps 'Star', presses volume key, or uses smartwatch to add a bookmark. |
| N9 | Action | Tap Stop | User ends the recording session. |
| N10 | Process | Background Extraction | Isolate runs Regex parsing to extract Action Items and Deadlines. |
| N11 | Process | Silence Trimmer | Removes silent gaps >3s from the audio buffer. |
| N12 | Process | Isar Transaction | System saves audio, transcript, markers, and extracted items to the encrypted database. |
| N13 | Screen | Note Detail Screen | Displays the finalized transcript with highlighted tags and markers. |
| ERR1 | State | Error: Denied | User denies mic permission. |
| ERR2 | State | Error: Storage Full | Device storage is critically low. |

## 3. Edge List
| ID | From → To | Trigger | Label |
|---|---|---|---|
| E1 | N1 → N2 | Tap | Initiate |
| E2 | N2 → N3 | System | Verify Capabilities |
| E3 | N3 → N4 | Missing | Request Mic |
| E4 | N3 → N5 | Granted | Check STT |
| E5 | N5 → N6 | Missing | Prompt Download |
| E6 | N5 → N7 | Ready | Start Recording |
| E7 | N7 → N8 | Tap/Key | Add Marker |
| E8 | N8 → N7 | System | Marker Saved |
| E9 | N7 → N9 | Tap 'Stop' | End Session |
| E10 | N9 → N11 | System | Optimize Audio |
| E11 | N11 → N10 | System | Parse Text |
| E12 | N10 → N12 | System | Save Data |
| E13 | N12 → N13 | Success | Show Result |

## 4. Decision Points
- **Permission Check (N3)**
  - *Condition*: Mic granted?
  - *Yes*: Proceed to Check STT (N5).
  - *No*: Show Permission Request (N4). If denied -> Exit to ERR1.
- **STT Model Check (N5)**
  - *Condition*: Offline language pack installed?
  - *Yes*: Start Recording (N7).
  - *No*: Show Model Download Prompt (N6).

## 5. Exit Points
- **Success Exit**: User views the structured note on the Note Detail Screen (N13).
- **Abandonment Exit**: User taps 'Cancel' during recording -> Session discarded -> Return to Home Dashboard (N1).
- **Error Exits**: 
  - ERR1 (Permission Denied) -> Return to Home (N1).
  - ERR2 (Storage Full) -> Show banner -> Prevent recording.

## 6. Error Paths
| ID | Trigger | Affected Nodes | Recovery |
|---|---|---|---|
| P1 | User permanently denies mic. | N4 → ERR1 | Provide a settings shortcut button in the error dialog. |
| P2 | Storage fills up during live recording. | N7 → ERR2 | Auto-stop the recording, save the buffer, and show "Storage Full" warning. |
| P3 | OS terminates background extraction isolate. | N10 | Retry parsing when the user opens the Note Detail Screen. |
