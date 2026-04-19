// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_title => 'Notulensi';

  @override
  String get archive => 'ARCHIVE';

  @override
  String get search_notes => 'SEARCH NOTES...';

  @override
  String get recording => 'RECORDING';

  @override
  String get listen => 'LISTEN';

  @override
  String get no_notes => 'No notes found.';

  @override
  String get processed => 'PROCESSED';

  @override
  String get key_highlights => 'KEY HIGHLIGHTS';

  @override
  String get no_action_items => 'No action items extracted yet.';

  @override
  String get delete_note => 'DELETE NOTE?';

  @override
  String get cancel => 'CANCEL';

  @override
  String get delete => 'DELETE';

  @override
  String get rename_folder => 'RENAME FOLDER';

  @override
  String get save => 'SAVE';

  @override
  String get stt_ready => 'OFFLINE STT READY';

  @override
  String get stt_required => 'DOWNLOAD REQUIRED';
}
