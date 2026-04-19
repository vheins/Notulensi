import 'package:get/get.dart';
import '../../features/notes/presentation/pages/home_screen.dart';
import '../../features/notes/presentation/pages/note_detail_screen.dart';
import '../../features/security/presentation/pages/auth_gate_screen.dart';

class AppRoutes {
  static const home = '/home';
  static const authGate = '/';
  static const noteDetail = '/note/:id';

  static final pages = [
    GetPage(
      name: home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: authGate,
      page: () => const AuthGateScreen(),
    ),
    GetPage(
      name: noteDetail,
      page: () => const NoteDetailScreen(),
    ),
  ];
}
