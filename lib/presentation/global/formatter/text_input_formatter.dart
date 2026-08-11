import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class GroupingFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.replaceAll(' ', '');

    String formatted = text.replaceAllMapped(
      RegExp(r".{4}"),
      (match) => "${match.group(0)} ",
    );
    String finalSortedText = formatted.trim();

    return newValue.copyWith(
      text: finalSortedText,
      selection: TextSelection.collapsed(offset: finalSortedText.length),
    );
  }
}

class ThousandsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    String newText = newValue.text.replaceAll(',', '');

    if (double.tryParse(newText) != null) {
      final formatter = NumberFormat("#,###");
      final formattedText = formatter.format(int.parse(newText));

      return TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }

    return newValue;
  }
}
