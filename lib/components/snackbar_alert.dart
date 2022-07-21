import 'package:flutter/material.dart';

snackBarAlert(BuildContext context, String label) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      label,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    ),
    backgroundColor: Colors.black,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    duration: const Duration(milliseconds: 1500),
  ));
}
