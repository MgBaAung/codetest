import 'package:b2b_freshmore/presentation/global/formatter/ph_no_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('phone formatter filters input in a text field', (tester) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextField(
            key: const Key('phone-field'),
            controller: controller,
            keyboardType: TextInputType.phone,
            inputFormatters: [PhNoFormatter()],
          ),
        ),
      ),
    );

    await tester.enterText(find.byKey(const Key('phone-field')), '09a12345678');
    await tester.pump();

    expect(controller.text, '0912345678');
    expect(find.byType(TextField), findsOneWidget);
  });
}
