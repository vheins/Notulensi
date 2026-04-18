# STT Engine Selection: Notulensi

## 1. Requirements Overview
- **Mandate**: 100% Offline.
- **Constraint**: APK Size < 25MB.
- **Platform**: Flutter (Android/iOS).

## 2. Options Comparison

| Feature | Vosk (Small Model) | System STT (OS Native) | Whisper (Tiny) |
| :--- | :--- | :--- | :--- |
| **Offline Support** | 100% (Built-in) | Device Dependent | 100% (Built-in) |
| **Model Size** | ~40MB - 50MB | 0MB (Shared OS) | ~75MB |
| **APK Impact** | High (~60MB total) | Low (< 5MB) | Very High (~85MB) |
| **Accuracy** | Good/Consistent | High (if online/DL) | Excellent |
| **Latency** | Low (Local) | Low (Local) | High (CPU dependent) |

## 3. The Conflict: Offline vs. Size
- **Vosk** provides the best "out-of-the-box" offline experience but makes hitting the **25MB APK** limit impossible with a bundled model.
- **System STT** (`speech_to_text` plugin) uses the native Android/iOS speech engines. These are 0MB impact on the APK, but **offline functionality depends on the user downloading offline language packs** in their system settings.

## 4. Final Decision: Hybrid System STT Approach

To satisfy the **< 25MB APK** constraint while maintaining **100% Offline** capability, Notulensi will use **System STT** as the primary engine.

### 4.1 Implementation Strategy
1. **Primary Engine**: Use the `speech_to_text` Flutter package.
2. **User Guidance**: Upon first run, the app will check for offline speech recognition capability. If unavailable, it will guide the user through a 1-click prompt to their OS settings to download the offline language pack (Standard behavior for privacy apps).
3. **Model Download (Optional/Phase 2)**: Provide an "Advanced Offline Mode" in settings where the user can choose to download a Vosk model (~45MB) to the app's internal storage. This keeps the initial APK size low while ensuring reliability for power users.

## 5. Rationale
- **Size Compliance**: Bundling any reliable STT model (Vosk/Whisper) would push the APK to 50MB+, violating a core project constraint.
- **Privacy**: Both System STT (when offline) and Vosk process audio locally on the device.
- **UX**: System STT provides the most "native" feel and better battery efficiency by utilizing specialized hardware (DSP/NPU) when available on modern phones.
