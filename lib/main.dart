import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/bindings/initial_binding.dart';
import 'core/security/secure_storage_service.dart';
import 'core/theme/notulensi_theme.dart';
import 'features/security/presentation/pages/auth_gate_screen.dart';
import 'features/notes/presentation/pages/home_screen.dart';
import 'features/notes/presentation/pages/note_detail_screen.dart';
import 'features/notes/bindings/note_detail_binding.dart';
import 'features/notes/presentation/pages/folder_detail_screen.dart';
import 'features/recording/presentation/pages/recording_screen.dart';
import 'features/recording/bindings/recording_binding.dart';
import 'features/storage/presentation/pages/storage_dashboard.dart';
import 'features/settings/presentation/pages/settings_screen.dart';
import 'core/database/isar_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SecureStorageService first to retrieve/generate database seed
  final secureStorage = SecureStorageService();
  Get.put<SecureStorageService>(secureStorage, permanent: true);

  // Retrieve or generate the encryption seed before Isar initialization
  final databaseSeed = await secureStorage.getOrCreateDatabaseSeed();

  // Initialize Isar Service with the encryption seed
  final isarService = IsarService();
  await isarService.init(encryptionSeed: databaseSeed);
  Get.put<IsarService>(isarService, permanent: true);

  runApp(const NotulensiApp());
}

class NotulensiApp extends StatelessWidget {
  const NotulensiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Notulensi',
      debugShowCheckedModeBanner: false,
      theme: NotulensiTheme.darkTheme,
      initialBinding: InitialBinding(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('id'), // Indonesian
      ],
      initialRoute: '/auth',
      getPages: [
        GetPage(name: '/auth', page: () => const AuthGateScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(
          name: '/notes/:id',
          page: () => const NoteDetailScreen(),
          binding: NoteDetailBinding(),
        ),
        GetPage(name: '/folders/:id', page: () => const FolderDetailScreen()),
        GetPage(
          name: '/recording',
          page: () => const RecordingScreen(),
          binding: RecordingBinding(),
        ),
        GetPage(name: '/storage', page: () => const StorageDashboardScreen()),
        GetPage(name: '/settings', page: () => const SettingsScreen()),
      ],
    );
  }
}
