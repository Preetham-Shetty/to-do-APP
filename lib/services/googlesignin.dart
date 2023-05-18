import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todoapp/pages/landing_page.dart';
import 'package:todoapp/pages/login_page.dart';

class GoogleSigninProvider extends ChangeNotifier {
  handleRoutes() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return const LandingPage();
          } else {
            return const LoginPage();
          }
        });
  }

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogIn() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    await FirebaseAuth.instance.signInWithCredential(credential);

    notifyListeners();
  }

  Future googleLogOut() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
