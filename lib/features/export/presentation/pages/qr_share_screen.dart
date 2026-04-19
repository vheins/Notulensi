import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../core/theme/notulensi_theme.dart';
import '../../services/qr_sync_service.dart';

class QrShareScreen extends StatefulWidget {
  final String title;
  final String transcript;

  const QrShareScreen({super.key, required this.title, required this.transcript});

  @override
  State<QrShareScreen> createState() => _QrShareScreenState();
}

class _QrShareScreenState extends State<QrShareScreen> {
  late List<String> chunks;
  int currentIndex = 0;
  final qrSyncService = Get.find<QrSyncService>();

  @override
  void initState() {
    super.initState();
    chunks = qrSyncService.encodeTranscript(widget.transcript);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<NotulensiColors>()!;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(widget.title.toUpperCase(), style: const TextStyle(letterSpacing: 2, fontSize: 14)),
        backgroundColor: colors.background,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: QrImageView(
                data: chunks[currentIndex],
                version: QrVersions.auto,
                size: 280,
                gapless: false,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'CHUNK ${currentIndex + 1} OF ${chunks.length}',
              style: TextStyle(color: colors.textLow, letterSpacing: 2, fontSize: 12),
            ),
            const SizedBox(height: 16),
            if (chunks.length > 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
                    onPressed: currentIndex > 0 ? () => setState(() => currentIndex--) : null,
                  ),
                  const SizedBox(width: 40),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                    onPressed: currentIndex < chunks.length - 1 ? () => setState(() => currentIndex++) : null,
                  ),
                ],
              ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'SCAN WITH ANOTHER NOTULENSI APP TO SYNC OFFLINE',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white38, fontSize: 10, letterSpacing: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
