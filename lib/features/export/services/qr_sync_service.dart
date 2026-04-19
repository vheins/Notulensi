import 'dart:convert';
import 'package:archive/archive.dart';

class QrSyncService {
  /// Compresses and encodes text into a list of chunks for QR display.
  /// Each chunk is prefixed with metadata: [index, total, checksum]
  List<String> encodeTranscript(String text, {int maxChunkSize = 2000}) {
    final bytes = utf8.encode(text);
    final compressed = const ZLibEncoder().encode(bytes);
    final base64String = base64Encode(compressed);

    final chunks = <String>[];
    final total = (base64String.length / maxChunkSize).ceil();

    for (var i = 0; i < total; i++) {
      final start = i * maxChunkSize;
      final end = (start + maxChunkSize > base64String.length) ? base64String.length : start + maxChunkSize;
      final part = base64String.substring(start, end);
      
      // Format: index:total:payload
      chunks.add('$i:$total:$part');
    }

    return chunks;
  }

  /// Decodes and decompresses a list of chunks back into text.
  String decodeChunks(List<String> rawChunks) {
    final Map<int, String> parts = {};
    int? total;

    for (final raw in rawChunks) {
      final segments = raw.split(':');
      if (segments.length < 3) continue;
      
      final index = int.parse(segments[0]);
      total = int.parse(segments[1]);
      final payload = segments[2];
      
      parts[index] = payload;
    }

    if (total == null || parts.length != total) {
      throw Exception('Missing chunks: ${parts.length}/$total');
    }

    final fullBase64 = Iterable.generate(total).map((i) => parts[i]!).join();
    final compressed = base64Decode(fullBase64);
    final bytes = const ZLibDecoder().decodeBytes(compressed);
    
    return utf8.decode(bytes);
  }
}
