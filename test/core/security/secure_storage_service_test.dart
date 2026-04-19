import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notulensi/core/security/secure_storage_service.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockFlutterSecureStorage mockStorage;
  late SecureStorageService secureStorageService;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    secureStorageService = SecureStorageService(storage: mockStorage);
  });

  group('SecureStorageService - getOrCreateDatabaseSeed', () {
    const seedKey = 'isar_database_seed';

    test('should return existing seed if it exists in storage', () async {
      final expectedSeed = Uint8List.fromList(List.generate(32, (i) => i));
      final base64Seed = base64Encode(expectedSeed);

      when(() => mockStorage.read(key: seedKey))
          .thenAnswer((_) async => base64Seed);

      final result = await secureStorageService.getOrCreateDatabaseSeed();

      expect(result, equals(expectedSeed));
      verify(() => mockStorage.read(key: seedKey)).called(1);
      verifyNever(() => mockStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ));
    });

    test('should generate, store and return a new seed if none exists', () async {
      when(() => mockStorage.read(key: seedKey))
          .thenAnswer((_) async => null);
      when(() => mockStorage.write(key: seedKey, value: any(named: 'value')))
          .thenAnswer((_) async => {});

      final result = await secureStorageService.getOrCreateDatabaseSeed();

      expect(result.length, equals(32));
      verify(() => mockStorage.read(key: seedKey)).called(1);
      verify(() => mockStorage.write(
            key: seedKey,
            value: any(named: 'value'),
          )).called(1);
    });

    test('should generate new seed if existing data is corrupted (invalid base64)', () async {
      when(() => mockStorage.read(key: seedKey))
          .thenAnswer((_) async => 'not-a-base64-string!!!');
      when(() => mockStorage.write(key: seedKey, value: any(named: 'value')))
          .thenAnswer((_) async => {});

      final result = await secureStorageService.getOrCreateDatabaseSeed();

      expect(result.length, equals(32));
      verify(() => mockStorage.read(key: seedKey)).called(1);
      verify(() => mockStorage.write(
            key: seedKey,
            value: any(named: 'value'),
          )).called(1);
    });
  });
}
