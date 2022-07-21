import 'package:flutter/material.dart';

Widget createStockForm(String label, TextEditingController controller,
    TextInputType textInputType, bool validate) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
    child: TextField(
      autofocus: true,
      textInputAction: TextInputAction.next,
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        fillColor: Color.fromARGB(255, 10, 120, 167),
        hintText: label,
        errorText: validate ? "Digite corretamente." : null,
      ),
    ),
  );
}
