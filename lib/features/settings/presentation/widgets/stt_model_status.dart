import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/notulensi_theme.dart';
import '../../../intelligence/services/stt_status_service.dart';

class SttModelStatus extends StatefulWidget {
  const SttModelStatus({super.key});

  @override
  State<SttModelStatus> createState() => _SttModelStatusState();
}

class _SttModelStatusState extends State<SttModelStatus> {
  final SttStatusService _service = Get.find<SttStatusService>();
  bool _isReady = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    final ready = await _service.isOfflineSttAvailable();
    if (mounted) {
      setState(() {
        _isReady = ready;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<NotulensiColors>()!;

    if (_isLoading) {
      return const LinearProgressIndicator();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _isReady ? colors.success.withAlpha(50) : colors.error.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _isReady ? Icons.check_circle_outline_rounded : Icons.error_outline_rounded,
                color: _isReady ? colors.success : colors.error,
              ),
              const SizedBox(width: 12),
              Text(
                _isReady ? 'OFFLINE STT READY' : 'DOWNLOAD REQUIRED',
                style: TextStyle(
                  color: colors.textHigh,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          if (!_isReady) ...[
            const SizedBox(height: 12),
            Text(
              'High-fidelity offline transcription requires OS-level language packs. Please ensure "English (US)" is downloaded in your device settings.',
              style: TextStyle(color: colors.textLow, fontSize: 13),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Link to system STT settings (implementation varies by OS)
                Get.snackbar('System Settings', 'Please open Settings > Languages > Offline Speech.');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 40),
              ),
              child: const Text('OPEN SETTINGS'),
            ),
          ],
        ],
      ),
    );
  }
}
