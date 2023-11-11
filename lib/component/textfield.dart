import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class textField extends StatelessWidget {
  final String value;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType keyboardType;
  final EdgeInsets contentPadding;
  final EdgeInsets padding;
  final double? width;
  final double? height;
  final bool enabled;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final void Function(String)? onSubmitted;
  final Color fillColor;
  final Color borderColor;
  final Color textColor;
  final Color hintColor;
  final FocusNode? focusNode;
  final bool autoFocus;
  final TextAlign textAlign;
  final TextEditingController? controller;
  final String? errorText;
  final TextStyle? hintStyle;

  const textField(
    this.value, {
    Key? key,
    this.inputFormatter,
    this.keyboardType = TextInputType.text,
    this.contentPadding = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
    this.width,
    this.height,
    this.maxLength,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onSubmitted,
    this.fillColor = const Color(0xFFE6E6E6),
    this.borderColor = const Color(0xFFE6E6E6),
    this.textColor = const Color(0xFF000000),
    this.hintColor = const Color(0xFF8A8A8A),
    this.focusNode,
    this.autoFocus = true,
    this.textAlign = TextAlign.start,
    this.controller,
    this.errorText,
    this.hintStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: width,
        height: height,
        child: TextField(
          key: key,
          controller: controller,
          textAlign: textAlign,
          autofocus: autoFocus,
          focusNode: focusNode,
          enabled: enabled,
          maxLength: maxLength,
          obscureText: false,
          textInputAction: TextInputAction.next,
          maxLines: 6,
          minLines: 1,
          decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: fillColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: borderColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: borderColor)),
              contentPadding: contentPadding,
              disabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: borderColor)),
              hintText: value,
              hintStyle: hintStyle,
              errorText: errorText,
              errorStyle: const TextStyle(color: Colors.red, fontSize: 18)),
          style: TextStyle(
            fontSize: 19,
            color: textColor,
            fontWeight: FontWeight.w400,
          ),
          keyboardType: keyboardType,
          inputFormatters: inputFormatter,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
        ),
      ),
    );
  }
}
