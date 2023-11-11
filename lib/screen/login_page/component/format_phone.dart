// phone_formatter.dart
import 'package:flutter/services.dart';

class PhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String formattedText = newValue.text
        .replaceAll(RegExp(r'\D'), ''); // Remove non-digit characters
    if (formattedText.length > 10) {
      formattedText = formattedText.substring(0, 10);
    }

    if (formattedText.isNotEmpty && formattedText.length >= 3) {
      formattedText =
          '${formattedText.substring(0, 3)}-${formattedText.substring(3)}';
    }

    if (formattedText.isNotEmpty && formattedText.length >= 7) {
      formattedText =
          '${formattedText.substring(0, 7)}-${formattedText.substring(7)}';
    }

    // Handle backspace: allow deleting the last digit
    if (oldValue.text.length > newValue.text.length &&
        formattedText.isNotEmpty) {
      formattedText = formattedText.substring(0, formattedText.length - 1);
    }

    // Handle clearing the text
    if (formattedText.isEmpty) {
      return TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
