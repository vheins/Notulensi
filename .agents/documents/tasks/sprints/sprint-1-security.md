# Sprint 1: Foundational Security (Safe-Box)

**Goal**: Implement the core biometric security gate and encrypted database initialization.

## Tasks
| Task ID | Title | Description | Priority |
|---------|-------|-------------|----------|
| S1-001 | Secure Storage Init | Setup `flutter_secure_storage` to handle AES seeds. | High |
| S1-002 | Biometric Integration | Implement `local_auth` service and login cubit. | High |
| S1-003 | Encrypted Isar Setup | Initialize Isar with encryption keys derived from biometrics. | Critical |
| S1-004 | Security Gate UI | Create the splash-screen biometric overlay. | Medium |
| S1-005 | Unit Tests: Security | Verify key derivation and authentication logic. | High |

## Definition of Done
- App requires biometrics on launch if enabled.
- Database cannot be opened without a valid biometric token.
- Encryption keys are never stored in plain text.
