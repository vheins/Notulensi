import 'package:get/get.dart';
import '../../features/dashboard/presentation/pages/home_page.dart';

class AppRoutes {
  static const home = '/';

  static final pages = [
    GetPage(
      name: home,
      page: () => const HomePage(),
    ),
  ];
}
