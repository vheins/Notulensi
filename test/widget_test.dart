import 'package:flutter_test/flutter_test.dart';
import 'package:notulensi/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NotulensiApp());

    // Verify that the splash text is present.
    expect(find.text('The Obsidian Archive'), findsOneWidget);
  });
}
