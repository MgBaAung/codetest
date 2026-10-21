import 'package:b2b_freshmore/presentation/global/formatter/ph_no_formatter.dart';
import 'package:b2b_freshmore/presentation/global/formatter/text_input_formatter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ThousandsFormatter', () {
    final formatter = ThousandsFormatter();

    test('groups whole number digits', () {
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: '1234'),
        const TextEditingValue(text: '1234567'),
      );

      expect(result.text, '1,234,567');
      expect(result.selection, const TextSelection.collapsed(offset: 9));
    });

    test('does not throw or format decimal input', () {
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: '12'),
        const TextEditingValue(text: '12.5'),
      );

      expect(result.text, '12.5');
    });

    test('keeps an empty value empty', () {
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: '1000'),
        const TextEditingValue(text: ''),
      );

      expect(result.text, isEmpty);
    });
  });

  group('PhNoFormatter', () {
    final formatter = PhNoFormatter();

    test('strips non-digits while retaining an international prefix', () {
      final result = formatter.formatEditUpdate(
        const TextEditingValue(),
        const TextEditingValue(text: '+95 (9) 123-4567'),
      );

      expect(result.text, '+9591234567');
    });

    test('rejects unsupported prefixes', () {
      const oldValue = TextEditingValue(text: '09');
      final result = formatter.formatEditUpdate(
        oldValue,
        const TextEditingValue(text: '123'),
      );

      expect(result, oldValue);
    });
  });
}
