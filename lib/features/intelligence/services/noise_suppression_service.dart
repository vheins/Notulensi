import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';

class NoiseSuppressionService {
  /// Processes an audio file to remove background noise using FFmpeg's 'afftdn' filter.
  /// This is an offline, hardware-accelerated process.
  Future<String?> suppressNoise(String inputPath) async {
    final outputPath = inputPath.replaceAll('.m4a', '_clean.m4a');
    
    // afftdn: FFT-based denoiser
    // highpass: removes low frequency hum (e.g. AC, fans)
    final command = '-i $inputPath -af "highpass=f=200, afftdn=nr=12:nf=-25" $outputPath';

    final session = await FFmpegKit.execute(command);
    final returnCode = await session.getReturnCode();

    if (ReturnCode.isSuccess(returnCode)) {
      return outputPath;
    } else {
      return null;
    }
  }
}
