import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInput extends StatelessWidget {
  final String labelText;
  final int maxLines;
  final bool multiline;
  final bool numeric;
  final TextEditingController controller;
  String? Function(String?)? validator;

  AppInput({
    super.key,
    this.labelText = "",
    this.maxLines = 1,
    this.multiline = false,
    this.numeric = false,
    this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final (keyboardType, inputFormatters, textInputAction) = getInputType(
      numeric,
      multiline,
    );
    final style = numeric
        ? TextStyle(fontSize: 20, fontWeight: FontWeight.w500)
        : TextStyle(fontSize: 16);

    return TextFormField(
      controller: controller,
      validator: validator,
      minLines: multiline ? 3 : 1,
      maxLines: multiline ? null : maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      style: style,
      decoration: InputDecoration(labelText: labelText),
    );
  }

  (
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    TextInputAction? textInputAction,
  )
  getInputType(bool numeric, bool multiline) {
    TextInputType? keyboardType;
    List<TextInputFormatter>? inputFormatters;
    TextInputAction? textInputAction;
    if (numeric) {
      keyboardType = const TextInputType.numberWithOptions(decimal: true);
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*[.,]?[0-9]*$')),
      ];
    } else if (multiline) {
      keyboardType = TextInputType.multiline;
    }

    if (multiline) {
      textInputAction = TextInputAction.newline;
    } else if (numeric) {
      textInputAction = TextInputAction.done;
    }

    return (keyboardType, inputFormatters, textInputAction);
  }
}
