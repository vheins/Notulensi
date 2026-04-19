import 'package:flutter/material.dart';
import '../../../intelligence/domain/regex_rules.dart';

class RedactedTextView extends StatelessWidget {
  final String text;
  final bool isRedacted;
  final TextStyle? style;

  const RedactedTextView({
    super.key,
    required this.text,
    required this.isRedacted,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    if (!isRedacted) {
      return Text(text, style: style);
    }

    // Simple redaction logic for now: redact emails
    final redactedText = text.replaceAll(RegexRules.email, '[REDACTED]');

    return Text(
      redactedText,
      style: style,
    );
  }
}
