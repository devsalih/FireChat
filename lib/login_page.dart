import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInScreen(actions: [
      VerifyPhoneAction((context, _) {
        Navigator.pushNamed(context, '/phone');
      }),
      AuthStateChangeAction<SignedIn>((context, state) {
        if (!state.user!.emailVerified) {
          Navigator.pushNamed(context, '/verify');
        } else {
          Navigator.pushReplacementNamed(context, '/profile');
        }
      }),
      AuthStateChangeAction<UserCreated>((context, state) {
        Navigator.pushNamed(context, '/verify');
      })
    ]);
  }
}
