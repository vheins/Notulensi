# Technical Design Document (TDD): Notulensi

## 1. System Architecture
Notulensi utilizes a **Feature-based Clean Architecture** for modularity and high performance in an offline-first environment.

### 1.1 Layers
- **Presentation**: Flutter/GetX.
- **Domain**: Pure Dart Use Cases and Entities.
- **Data**: Isar Repository and Infrastructure.
- **External**: OS Native APIs (Camera, Biometrics, Bluetooth, Calendar).

## 2. Technology Stack
- **Framework**: Flutter (v3.19+).
- **State Management**: `get` (GetX).
- **Database**: Isar (Encrypted, Full-text Search).
- **STT**: `speech_to_text` (Primary) / `vosk_flutter` (Pro).
- **Audio**: `record`, `audioplayers`, and custom VAD filters.
- **Hardware**: `local_auth` (Biometrics), `hardware_buttons` (Volume-keys).
- **Multimedia**: `camera` and `pdf` packages.

## 3. Advanced Feature Design

### 3.1 Biometric Safe-Box (Security)
- **Encryption**: Uses Isar's AES-GCM 256 encryption.
- **Key Management**: Keys are generated locally and stored in the **Secure Enclave** (iOS) or **KeyStore** (Android) via `flutter_secure_storage`.
- **Flow**: App requests `local_auth` -> Success -> Retrieve key -> Open Isar with key.

### 3.2 Offline Intelligence (Processing)
- **Noise Suppression**: Implemented via Dart FFI using a lightweight C-library (e.g., Speex or RNNoise) to filter raw PCM buffers before STT.
- **Smart Speaker Tagging**: Uses **Voice Activity Detection (VAD)** to identify pauses > 500ms and frequency shifts to trigger automatic paragraph breaks.
- **Privacy Masking**: A local regex engine scans the final transcript for PII patterns (emails, SSNs, credit cards) and replaces them with `[REDACTED]`.

### 3.3 Hardware & Interaction (Interaction)
- **Physical Key Markers**: Intercepts volume button events while the app is in the foreground or background (using a foreground service on Android) to drop markers on the audio timeline.
- **Smartwatch Remote**: Uses a P2P Bluetooth protocol to sync start/stop/marker events with a companion WearOS/watchOS app.

### 3.4 Ecosystem & Sharing (Portability)
- **Zero-Network QR Sharing**: 
  - Transcripts are compressed using `Zlib`.
  - Large transcripts are split into multiple QR codes if they exceed 2KB.
  - The receiver app reassembles the chunks.
- **Audio-to-Calendar**: Bridges extracted deadlines to the `device_calendar` package, allowing local event creation without an internet connection.

## 4. Test Architecture (4-Concern Rule)
| Layer | Focus | Key Scenarios |
| :--- | :--- | :--- |
| **1. Database** | Security & Integrity | Encrypted read/write, Folder migration, Version snapshots. |
| **2. Service** | Logic & Optimization | Noise filter latency, QR compression ratio, VAD accuracy. |
| **3. State** | Guards & Auth | Biometric timeout, Permission re-verification, Ad-reward state. |
| **4. UI** | Responsive Interaction | Waveform bookmarking, PiP rendering, Gallery view. |

## 5. Security & Privacy Model
- **Absolute Local Residency**: meeting content never leaves the private app directory.
- **No Telemetry**: Zero analytics or crash reporting packages (Sentry/Firebase) are used.
- **Sandboxed Storage**: Images and audio are stored with `.nomedia` to prevent indexing by system galleries.
