import 'package:flutter_test/flutter_test.dart';
import 'package:notulensi/features/intelligence/domain/models/extracted_item.dart';
import 'package:notulensi/features/intelligence/domain/regex_rules.dart';

void main() {
  group('RegexRules - Fine-Grained Rules', () {
    test('should extract "i will" as action item', () {
      const text = 'i will send the report later';
      final results = RegexRules.parse(text);
      
      final item = results.firstWhere((e) => e.type == ExtractedType.actionItem);
      expect(item.content, equals('send the report later'));
    });

    test('should extract "we must" as action item', () {
      const text = 'we must implement the fix';
      final results = RegexRules.parse(text);
      
      final item = results.firstWhere((e) => e.type == ExtractedType.actionItem);
      expect(item.content, equals('implement the fix'));
    });

    test('should extract "please" as action item', () {
      const text = 'please call the client';
      final results = RegexRules.parse(text);
      
      final item = results.firstWhere((e) => e.type == ExtractedType.actionItem);
      expect(item.content, equals('call the client'));
    });

    test('should extract "due" as deadline', () {
      const text = 'due: tomorrow';
      final results = RegexRules.parse(text);
      
      final item = results.firstWhere((e) => e.type == ExtractedType.deadline);
      expect(item.content, equals('tomorrow'));
    });

    test('should extract "by" as deadline', () {
      const text = 'by: next monday';
      final results = RegexRules.parse(text);
      
      final item = results.firstWhere((e) => e.type == ExtractedType.deadline);
      expect(item.content, equals('next monday'));
    });
  });
}
