# Feature: Biometric Safe-Box

## 1. Stories
- **As a user**, I want to lock my meeting notes with FaceID/Fingerprint so that unauthorized people cannot read them if they hold my phone.
- **As a user**, I want the notes to be encrypted on the disk so that they are safe even if the device is rooted.

## 2. User Flow
1. App Launch -> Check `SecurityService.isSafeBoxEnabled`.
2. If `true` -> Show `SafeBoxOverlay`.
3. User Taps "Unlock" -> System Biometric Dialog.
4. On Success -> `SecurityService` derives Isar Key -> Database Opens -> App Home.

## 3. Business Rules
- Safe-Box is disabled by default.
- Enabling Safe-Box requires a master backup seed to be displayed (one-time).
- The biometric session expires if the app is in the background for >5 minutes.

## 4. Data Model
Refer to `application/modules/security/overview.md` for the `SecurityState` model.
