import 'dart:io';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';

class SilenceTrimmer {
  /// Trims silences longer than 3 seconds from the given audio file.
  /// Returns the path to the trimmed file, or original if failed.
  Future<String> trimSilence(String inputPath) async {
    final inputFile = File(inputPath);
    if (!await inputFile.exists()) return inputPath;

    final outputPath = inputPath.replaceFirst('.wav', '_trimmed.wav');
    
    // FFmpeg command to remove silences
    // silenceremove=stop_periods=-1:stop_duration=3:stop_threshold=-40dB
    // -1: remove all periods of silence
    // 3: duration in seconds
    // -40dB: threshold for what is considered silence
    final command = '-i "$inputPath" -af "silenceremove=stop_periods=-1:stop_duration=3:stop_threshold=-40dB" -y "$outputPath"';

    final session = await FFmpegKit.execute(command);
    final returnCode = await session.getReturnCode();

    if (ReturnCode.isSuccess(returnCode)) {
      return outputPath;
    } else {
      // Log failure if needed
      return inputPath;
    }
  }

  /// Calculates space saved in bytes.
  Future<int> calculateSpaceSaved(String originalPath, String trimmedPath) async {
    if (originalPath == trimmedPath) return 0;
    
    final originalFile = File(originalPath);
    final trimmedFile = File(trimmedPath);
    
    if (await originalFile.exists() && await trimmedFile.exists()) {
      return (await originalFile.length()) - (await trimmedFile.length());
    }
    return 0;
  }
}
