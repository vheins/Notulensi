import 'models/extracted_item.dart';

class RegexRules {
  /// Matches "To do: [Task]" or "Task: [Task]" (case insensitive)
  static final actionItem = RegExp(
    r'(?:to do|task):\s*(.*)',
    caseSensitive: false,
  );

  /// Matches "Deadline: [Date]"
  static final deadline = RegExp(
    r'deadline:\s*(.*)',
    caseSensitive: false,
  );

  /// Matches email addresses
  static final email = RegExp(
    r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b',
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
