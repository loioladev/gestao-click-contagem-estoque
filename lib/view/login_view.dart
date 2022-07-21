import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../login/login.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white
            ] //[Color(0xFF09D7DB), Color(0xFF16B4F2), Color(0xFF0968DB)],
            ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(
            child: Image(
              fit: BoxFit.cover,
              height: 350,
              image: AssetImage("assets/logo_vipoint.png"),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SignInButton(
              Buttons.Google,
              elevation: 6,
              padding: const EdgeInsets.all(4),
              mini: false,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              text: "Logar com Google",
              onPressed: () {
                Login().signInWithGoogle();
              },
            ),
          )
        ],
      ),
    ));
  }
}
