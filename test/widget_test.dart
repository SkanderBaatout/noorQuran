import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quran_app/main.dart';

void main() {
  testWidgets('Noor Quran se lance sans erreur', (WidgetTester tester) async {
    // ↓ ICI, avant tout le reste
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const QuranApp());
    await tester.pump();

    expect(find.byType(QuranApp), findsOneWidget);
  });
}
