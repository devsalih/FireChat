import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmailVerificationScreen(actions: [
      EmailVerifiedAction(() {
        Navigator.pushReplacementNamed(context, '/profile');
      }),
      AuthCancelledAction((context) {
        FirebaseUIAuth.signOut(context: context);
        Navigator.pushReplacementNamed(context, '/login');
      }),
    ]);
  }
}
