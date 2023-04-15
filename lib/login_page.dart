import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'firebase_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      actions: [
        VerifyPhoneAction((context, _) {
          Navigator.pushNamed(context, '/phone');
        }),
        AuthStateChangeAction<SignedIn>((context, state) {
          FirebaseService.updateLastSignInTime();
          Navigator.pushReplacementNamed(context, '/');
        }),
        AuthStateChangeAction<UserCreated>((context, state) {
          FirebaseService.writeUser();
          Navigator.pushNamed(context, '/');
        }),
      ],
      footerBuilder: (context, _) => TextButton(
        onPressed: () => FirebaseService.signInAnonymously().then((_) {
          Navigator.pushReplacementNamed(context, '/');
        }),
        child: const Text('Sign in anonymously'),
      ),
    );
  }
}
