import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../core/theme/notulensi_theme.dart';
import '../../services/qr_sync_service.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final Set<String> scannedChunks = {};
  int? totalChunks;
  final qrSyncService = Get.find<QrSyncService>();
  bool isProcessing = false;

  void _onDetect(BarcodeCapture capture) {
    if (isProcessing) return;

    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      final rawValue = barcode.rawValue;
      if (rawValue != null && !scannedChunks.contains(rawValue)) {
        setState(() {
          scannedChunks.add(rawValue);
          final segments = rawValue.split(':');
          if (segments.length >= 2) {
            totalChunks = int.tryParse(segments[1]);
          }
        });

        if (totalChunks != null && scannedChunks.length == totalChunks) {
          _completeSync();
        }
      }
    }
  }

  Future<void> _completeSync() async {
    setState(() => isProcessing = true);
    try {
      final result = qrSyncService.decodeChunks(scannedChunks.toList());
      Get.back(result: result);
    } catch (e) {
      Get.snackbar('SYNC FAILED', 'Corrupted or incomplete QR data.',
          backgroundColor: Colors.red, colorText: Colors.white);
      setState(() {
        isProcessing = false;
        scannedChunks.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<NotulensiColors>()!;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('SYNC SCANNER', style: TextStyle(letterSpacing: 2, fontSize: 14)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: _onDetect,
          ),
          
          // Overlay UI
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: colors.primary, width: 2),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                if (totalChunks != null)
                  Text(
                    'PROGRESS: ${scannedChunks.length} / $totalChunks',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1),
                  ),
                const SizedBox(height: 16),
                const Text(
                  'ALIGN QR CODE WITHIN THE FRAME',
                  style: TextStyle(color: Colors.white54, fontSize: 10, letterSpacing: 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
