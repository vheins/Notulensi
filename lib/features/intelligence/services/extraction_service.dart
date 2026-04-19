import 'package:flutter/foundation.dart';
import '../domain/models/extracted_item.dart';
import '../domain/regex_rules.dart';

/// Service for extracting intelligence from transcripts.
/// Uses background isolates to prevent UI jank.
class ExtractionService {
  /// Analyzes text and returns a list of structured items.
  Future<List<ExtractedItem>> analyzeText(String text) async {
    if (text.isEmpty) return [];
    
    // Offload parsing to a background isolate
    return await compute(_parseInIsolate, text);
  }

  /// Redacts sensitive information (e.g. emails) from text.
  Future<String> redactText(String text) async {
    if (text.isEmpty) return '';
    
    return await compute(_redactInIsolate, text);
  }

  /// Top-level function for isolate computation
  static List<ExtractedItem> _parseInIsolate(String text) {
    return RegexRules.parse(text);
  }

  /// Top-level function for redaction in isolate
  static String _redactInIsolate(String text) {
    return text.replaceAll(RegexRules.email, '[REDACTED]');
  }
}
