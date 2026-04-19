import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/bindings/initial_binding.dart';
import 'core/navigation/app_routes.dart';
import 'core/theme/notulensi_theme.dart';

void main() {
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
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.pages,
    );
  }
}
