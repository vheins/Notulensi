import 'package:flutter/material.dart';
import 'core/theme/notulensi_theme.dart';

void main() {
  runApp(const NotulensiApp());
}

class NotulensiApp extends StatelessWidget {
  const NotulensiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notulensi',
      debugShowCheckedModeBanner: false,
      theme: NotulensiTheme.darkTheme,
      home: const Scaffold(
        body: Center(
          child: Text(
            'The Obsidian Archive',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
