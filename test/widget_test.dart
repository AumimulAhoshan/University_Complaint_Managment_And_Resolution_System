import 'package:flutter_test/flutter_test.dart';
import 'package:uniserva/app/app.dart';

void main() {
  testWidgets('UniServa app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const UniServaApp());

    expect(find.text('UniServa'), findsOneWidget);
  });
}