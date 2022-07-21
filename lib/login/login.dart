import 'package:atualiza_estoque/view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../view/default.dart';

class Login {
  // Verify if the user is already signed in and, if so,
  // take him to the main page
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return const DefaultView();
          } else {
            return const LoginView();
          }
        });
  }

  // Give the user permission to the home page
  // by signing with Google
  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Sign out from the main page and the account
  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
