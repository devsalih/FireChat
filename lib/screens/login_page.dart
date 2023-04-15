import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import '../services/firebase_service.dart';

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
          Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
        }),
        AuthStateChangeAction<UserCreated>((context, state) {
          FirebaseService.writeUser();
          Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
        }),
      ],
      footerBuilder: (context, _) => TextButton(
        onPressed: () => FirebaseService.signInAnonymously().then((_) {
          Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
        }),
        child: const Text('Sign in anonymously'),
      ),
    );
  }
}
