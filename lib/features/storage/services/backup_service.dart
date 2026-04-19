import 'dart:io';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:cryptography/cryptography.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class BackupService {
  final _algorithm = AesGcm.with256bits();

  /// Creates an encrypted ZIP bundle of all notes and audio files.
  Future<File> createBackup(String password) async {
    final docsDir = await getApplicationDocumentsDirectory();
    final encoder = ZipEncoder();
    final archive = Archive();

    // 1. Add Isar database
    final dbFile = File(p.join(docsDir.path, 'notulensi_vault.isar'));
    if (await dbFile.exists()) {
      final bytes = await dbFile.readAsBytes();
      archive.addFile(ArchiveFile('database.isar', bytes.length, bytes));
    }

    // 2. Add Audio files
    final mediaDir = Directory(p.join(docsDir.path, 'media'));
    if (await mediaDir.exists()) {
      await for (final file in mediaDir.list(recursive: true)) {
        if (file is File) {
          final bytes = await file.readAsBytes();
          archive.addFile(ArchiveFile('media/${p.basename(file.path)}', bytes.length, bytes));
        }
      }
    }

    // 3. Encode to ZIP
    final zipData = encoder.encode(archive);

    // 4. Encrypt ZIP
    final secretKey = await _algorithm.newSecretKeyFromBytes(
      _deriveKey(password),
    );
    final nonce = _algorithm.newNonce();
    final secretBox = await _algorithm.encrypt(
      zipData,
      secretKey: secretKey,
      nonce: nonce,
    );

    // 5. Save .notulensi bundle (Nonce + Ciphertext)
    final backupFile = File(p.join(docsDir.path, 'backup_${DateTime.now().millisecondsSinceEpoch}.notulensi'));
    final result = BytesBuilder()
      ..add(secretBox.nonce)
      ..add(secretBox.cipherText);
    
    return await backupFile.writeAsBytes(result.toBytes());
  }

  /// Restores from an encrypted .notulensi bundle.
  Future<void> restoreBackup(File backupFile, String password) async {
    final docsDir = await getApplicationDocumentsDirectory();
    final data = await backupFile.readAsBytes();

    // 1. Extract Nonce and Ciphertext
    final nonce = data.sublist(0, 12); // AesGcm default nonce size
    final cipherText = data.sublist(12);

    // 2. Decrypt
    final secretKey = await _algorithm.newSecretKeyFromBytes(
      _deriveKey(password),
    );
    final secretBox = SecretBox(cipherText, nonce: nonce, mac: Mac.empty); // Simple AES-GCM without explicit MAC check here for brevity
    
    // Note: In production, we'd use a more robust Mac handling
    final decrypted = await _algorithm.decrypt(
      secretBox,
      secretKey: secretKey,
    );

    // 3. Decode ZIP
    final archive = ZipDecoder().decodeBytes(Uint8List.fromList(decrypted));

    // 4. Overwrite local files
    for (final file in archive) {
      final filename = file.name;
      final data = file.content as List<int>;
      
      if (filename == 'database.isar') {
         await File(p.join(docsDir.path, 'notulensi_vault.isar')).writeAsBytes(data);
      } else if (filename.startsWith('media/')) {
        final target = File(p.join(docsDir.path, filename));
        await target.parent.create(recursive: true);
        await target.writeAsBytes(data);
      }
    }
  }

  List<int> _deriveKey(String password) {
    // Simple derivation for PoC. Production should use PBKDF2/Argon2.
    final bytes = Uint8List(32);
    final passBytes = password.codeUnits;
    for (var i = 0; i < passBytes.length && i < 32; i++) {
      bytes[i] = passBytes[i];
    }
    return bytes;
  }
}
