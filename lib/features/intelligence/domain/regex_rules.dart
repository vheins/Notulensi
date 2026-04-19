import 'models/extracted_item.dart';

class RegexRules {
  /// Matches explicit tasks and commitments
  /// Patterns: "to do:...", "task:...", "i will...", "we must..."
  static final actionItem = RegExp(
    r'(?:to do|task|i will|we must|please)[:\s]*(.*)',
    caseSensitive: false,
  );

  /// Matches deadlines and temporal constraints
  /// Patterns: "deadline:...", "by [Date]", "due [Date]"
  static final deadline = RegExp(
    r'(?:deadline|due|by)[:\s]*(.*)',
    caseSensitive: false,
  );

  /// Matches email addresses for contact extraction
  static final email = RegExp(
    r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b',
    caseSensitive: false,
  );

  /// Matches mentions of "Monday", "Tuesday", etc., or dates like "20/12/2023"
  static final temporalReference = RegExp(
    r'\b(?:monday|tuesday|wednesday|thursday|friday|saturday|sunday|tomorrow|today|next week|end of month)\b|\b\d{1,2}[/-]\d{1,2}[/-]\d{2,4}\b',
    caseSensitive: false,
  );

  /// Helper to convert matches to ExtractedItems
  static List<ExtractedItem> parse(String text) {
    final results = <ExtractedItem>[];

    // Action Items
    for (final match in actionItem.allMatches(text)) {
      results.add(ExtractedItem(
        content: match.group(1)?.trim() ?? '',
        type: ExtractedType.actionItem,
        offset: match.start,
        length: match.end - match.start,
      ));
    }

    // Deadlines
    for (final match in deadline.allMatches(text)) {
      results.add(ExtractedItem(
        content: match.group(1)?.trim() ?? '',
        type: ExtractedType.deadline,
        offset: match.start,
        length: match.end - match.start,
      ));
    }

    // Emails (Contacts)
    for (final match in email.allMatches(text)) {
      results.add(ExtractedItem(
        content: match.group(0)?.trim() ?? '',
        type: ExtractedType.contact,
        offset: match.start,
        length: match.end - match.start,
      ));
    }

    return results;
  }
}
