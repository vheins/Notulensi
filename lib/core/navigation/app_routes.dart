import 'package:get/get.dart';
import '../../features/dashboard/presentation/pages/home_page.dart';
import '../../features/security/presentation/pages/auth_gate_screen.dart';

class AppRoutes {
  static const home = '/home';
  static const authGate = '/';

  static final pages = [
    GetPage(
      name: home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: authGate,
      page: () => const AuthGateScreen(),
    ),
  ];
}
