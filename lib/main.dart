import 'package:atualiza_estoque/model/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: Login().handleAuthState(),
    theme: ThemeOfProject().themeData,
    debugShowCheckedModeBanner: false,
  ));
}
