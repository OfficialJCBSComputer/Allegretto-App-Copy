import 'package:flutter_test/flutter_test.dart';
import 'package:allegretto_app/main.dart';

void main() {
  testWidgets('App loads smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AllegrettoApp());

    // Verify that the AuthWrapper is present.
    expect(find.byType(AuthWrapper), findsOneWidget);
  });
}
