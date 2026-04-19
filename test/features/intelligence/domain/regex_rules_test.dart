import 'package:flutter_test/flutter_test.dart';
import 'package:notulensi/features/intelligence/domain/models/extracted_item.dart';
import 'package:notulensi/features/intelligence/domain/regex_rules.dart';

void main() {
  group('RegexRules', () {
    test('should extract action items with "To do:" prefix', () {
      const text = 'To do: Finish the report';
      final results = RegexRules.parse(text);
      
      final item = results.firstWhere((e) => e.type == ExtractedType.actionItem);
      expect(item.content, equals('Finish the report'));
    });

    test('should extract action items with "Task:" prefix', () {
      const text = 'Task: Buy groceries';
      final results = RegexRules.parse(text);
      
      final item = results.firstWhere((e) => e.type == ExtractedType.actionItem);
      expect(item.content, equals('Buy groceries'));
    });

    test('should extract deadlines', () {
      const text = 'Deadline: next Friday';
      final results = RegexRules.parse(text);
      
      final item = results.firstWhere((e) => e.type == ExtractedType.deadline);
      expect(item.content, equals('next Friday'));
    });

    test('should extract email addresses', () {
      const text = 'Contact me at test@example.com for details';
      final results = RegexRules.parse(text);
      
      final item = results.firstWhere((e) => e.type == ExtractedType.contact);
      expect(item.content, equals('test@example.com'));
    });

    test('should return empty list for irrelevant text', () {
      const text = 'Just some random meeting notes without structure.';
      final results = RegexRules.parse(text);
      
      expect(results, isEmpty);
    });
  });
}
