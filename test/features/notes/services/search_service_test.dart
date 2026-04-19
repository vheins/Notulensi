import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notulensi/core/database/isar_service.dart';
import 'package:isar/isar.dart';
import 'package:notulensi/shared/models/database/meeting_note.dart';

class MockIsarService extends Mock implements IsarService {}
class MockIsar extends Mock implements Isar {}
class MockMeetingNoteCollection extends Mock implements IsarCollection<MeetingNote> {}

void main() {
  test('SearchService placeholder', () {
    expect(true, isTrue);
  });
}
