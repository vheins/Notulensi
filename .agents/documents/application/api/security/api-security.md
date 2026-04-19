# API: Security & Safe-Box

## 1. Overview
Services for managing the biometric lock and encryption key lifecycle.

## 2. Endpoints (Internal Services)

### `SecurityService.authenticate()`
- **Type**: Future<bool>
- **Description**: Invokes the native biometric dialog.
- **Returns**: `true` on success, `false` on failure/cancel.

### `SecurityService.getDatabaseKey()`
- **Type**: Future<Uint8List>
- **Description**: Retrieves the raw AES-256 key from secure storage.
- **Validation**: Requires a successful `authenticate()` call in the current session.

### `SecurityService.toggleSafeBox(bool enable)`
- **Type**: Future<void>
- **Description**: Activates or deactivates the biometric gate.
