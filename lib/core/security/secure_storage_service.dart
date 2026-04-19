import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Service for managing hardware-backed secure storage.
/// Used primarily for storing AES encryption seeds for the local database.
class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(
                encryptedSharedPreferences: true,
              ),
              iOptions: IOSOptions(
                accessibility: KeychainAccessibility.first_unlock,
              ),
            );

  static const _databaseSeedKey = 'isar_database_seed';
  static const _safeBoxEnabledKey = 'safe_box_enabled';

  /// Check if SafeBox (biometric lock) is enabled.
  Future<bool> isSafeBoxEnabled() async {
    final value = await _storage.read(key: _safeBoxEnabledKey);
    return value == 'true';
  }

  /// Enable or disable SafeBox (biometric lock).
  Future<void> setSafeBoxEnabled(bool enabled) async {
    await _storage.write(key: _safeBoxEnabledKey, value: enabled.toString());
  }

  /// Retrieves the existing database seed or generates a new 32-byte random seed.
  /// The seed is stored in the device's secure enclave / keystore.
  Future<Uint8List> getOrCreateDatabaseSeed() async {
    final existingSeed = await _storage.read(key: _databaseSeedKey);
    
    if (existingSeed != null && existingSeed.isNotEmpty) {
      try {
        return base64Decode(existingSeed);
      } catch (e) {
        // Fallback if data is corrupted
        return _generateAndStoreNewSeed();
      }
    }

    return _generateAndStoreNewSeed();
  }

  Future<Uint8List> _generateAndStoreNewSeed() async {
    final random = Random.secure();
    final seed = Uint8List.fromList(
      List.generate(32, (_) => random.nextInt(256)),
    );

    await _storage.write(
      key: _databaseSeedKey,
      value: base64Encode(seed),
    );

    return seed;
  }

  /// Saves a string value to secure storage.
  Future<void> save(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Reads a string value from secure storage.
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// Clears all stored data. Use with caution as this makes encrypted data unrecoverable.
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
