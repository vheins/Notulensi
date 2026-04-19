# Testing: Security & Safe-Box

## 1. Overview
Ensures the biometric gate is impenetrable and that data is never decrypted without authorization.

## 2. Test Scenarios

### Positive Scenarios
- **Successful Unlock**: Mock successful `local_auth` -> Verify Isar opens with the correct key.
- **Key Persistence**: Reboot app -> Verify key can be retrieved again via biometrics.

### Negative Scenarios
- **Failed Auth**: Mock biometric rejection -> Verify Home Screen is NOT visible.
- **Biometric Unavailable**: Hardware without fingerprint/FaceID -> Verify app falls back to system PIN or prevents Safe-Box activation.

### Security Cases
- **Session Timeout**: Move app to background for 6 minutes -> Return -> Verify app is re-locked.
- **Key Extraction**: Verify the AES key is NEVER printed in logs or saved to unencrypted Shared Preferences.
