import 'package:flutter/material.dart';

Widget createStockForm(
    String label,
    TextEditingController controller,
    TextInputType textInputType,
    bool validate,
    TextInputAction textInputAction,
    Function? aux,
    FocusNode? focusNode) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
    child: TextField(
      onSubmitted: (value) {
        aux?.call();
      },
      focusNode: focusNode,
      textInputAction: textInputAction,
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 10, 120, 167),
        hintText: label,
        errorText: validate ? "Digite corretamente." : null,
      ),
    ),
  );
}
