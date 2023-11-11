// id_card_formatter.dart

import 'package:flutter/services.dart';

class IdCardFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String formattedText = newValue.text
        .replaceAll(RegExp(r'\D'), ''); // Remove non-digit characters

    if (formattedText.length > 13) {
      formattedText = formattedText.substring(0, 13);
    }

    if (formattedText.isNotEmpty && formattedText.length >= 2) {
      formattedText =
          '${formattedText.substring(0, 1)} ${formattedText.substring(1)}';
    }

    if (formattedText.isNotEmpty && formattedText.length >= 6) {
      formattedText =
          '${formattedText.substring(0, 6)} ${formattedText.substring(6)}';
    }

    if (formattedText.isNotEmpty && formattedText.length >= 11) {
      formattedText =
          '${formattedText.substring(0, 11)} ${formattedText.substring(11)}';
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
