import 'package:flutter/material.dart';

Future<void> showConfirmDialog(
  BuildContext context,
  String title,
  String description,
  String confirmBtnTxt,
  String cancelBtnTxt,
  Function onConfirmClicked,
) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(
          description,
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            child: Text(
              cancelBtnTxt,
              style: const TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // dismiss dialog
            },
          ),
          TextButton(
            child: Text(
              confirmBtnTxt,
              style: const TextStyle(color: Colors.black),
            ),
            onPressed: () {
              onConfirmClicked.call();
              Navigator.of(context).pop(); // dismiss dialog
            },
          ),
        ],
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      );
    },
  );
}
