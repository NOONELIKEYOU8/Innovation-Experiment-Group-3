import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_hello_personalized/main.dart';

void main() {
  testWidgets('Task counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const InnovationHelloApp());

    // Verify that our counter starts at 0 and shows personal info.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
    expect(find.text('姓名：周文宾'), findsOneWidget);
    expect(find.text('学号：20231060154'), findsOneWidget);

    // Tap the check icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.check_circle_outline));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
