import 'package:flutter/material.dart';

Widget loadingScreen() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget>[
        CircularProgressIndicator(),
        Text(
          "Carregando...",
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}
