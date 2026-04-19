class PiiMaskingService {
  static final _emailRegex = RegExp(
    r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}',
    caseSensitive: false,
  );

  static final _phoneRegex = RegExp(
    r'(\+\d{1,3}[-.\s]?)?(\(?\d{3}\)?[-.\s]?)?\d{3}[-.\s]?\d{4}',
  );

  static final _idRegex = RegExp(
    r'\b\d{2,3}[-]?\d{4,8}\b',
  );

  static final _creditCardRegex = RegExp(
    r'\b\d{4}[-\s]?\d{4}[-\s]?\d{4}[-\s]?\d{4}\b',
  );

  String maskPii(String text) {
    var result = text;

    result = result.replaceAllMapped(_emailRegex, (_) => '[EMAIL MASKED]');

    result = result.replaceAllMapped(_phoneRegex, (_) => '[PHONE MASKED]');

    result = result.replaceAllMapped(_idRegex, (_) => '[ID MASKED]');

    result = result.replaceAllMapped(_creditCardRegex, (_) => '[CARD MASKED]');

    return result;
  }

  bool containsPii(String text) {
    return _emailRegex.hasMatch(text) ||
        _phoneRegex.hasMatch(text) ||
        _idRegex.hasMatch(text) ||
        _creditCardRegex.hasMatch(text);
  }
}