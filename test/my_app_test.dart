import 'package:flutter_test/flutter_test.dart';
import 'package:ssi_wallet/main.dart'; // Replace with your app's import

void main() {
  testWidgets('MyWidget should display "Hello, World!"', (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp()); // Replace with your widget instance
    expect(find.text('Hello, World!'), findsOneWidget);
  });
}