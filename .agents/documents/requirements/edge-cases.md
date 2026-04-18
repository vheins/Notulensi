# Edge Cases: Notulensi

## 1. Hardware & System Constraints
- **Microphone Permission Denied:** User denies mic permission initially or revokes it in settings while the app is running.
- **Storage Full:** The device runs out of storage space during a long recording session.
- **Battery Low:** The system triggers power-saving mode or the device shuts down during an active recording.
- **Microphone Hardware Busy:** Another app (e.g., a phone call or voice assistant) takes control of the microphone while recording.

## 2. Audio & Transcription Quality
- **Heavy Background Noise:** High ambient noise levels significantly degrade transcription accuracy.
- **Overlapping Speakers:** Multiple people speaking simultaneously causes transcription jumble (as diarization is out of scope for MVP).
- **Whispered/Low Volume Audio:** The audio signal is too weak for the local STT model to process accurately.
- **Unrecognized Dialects/Jargon:** Use of highly specialized terminology or thick accents not supported by the offline model.

## 3. Data Integrity & State Management
- **App Crash during Recording:** The app terminates unexpectedly before the user taps 'Stop'.
- **Database Corruption:** The local Isar database becomes unreachable or corrupted.
- **Interrupting Events:** Incoming phone calls, alarms, or system notifications occurring during recording.
- **Very Long Recordings:** Sessions exceeding 2+ hours that might hit file size or memory limits.

## 4. UI/UX Edge Cases
- **Rapid Tap on UI:** User taps the 'Record' or 'Stop' button multiple times in rapid succession.
- **Search with Special Characters:** User enters complex regex-like characters in the search bar.
- **Large Note Deletion:** Deleting hundreds of notes at once causing temporary UI lag.
- **Zero-Length Recording:** User starts and stops a recording almost instantly.

## 5. Privacy & Export
- **Restricted Export Path:** User attempts to export a PDF to a system-protected or read-only directory.
- **Missing File Permissions:** App lacks 'Write External Storage' permissions on older Android versions when exporting.
- **Unexpected Internet Reconnection:** System connects to Wi-Fi mid-transcription (Ensuring privacy mandates remain strictly enforced).
