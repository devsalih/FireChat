import 'package:flutter/material.dart';

import '../services/firebase_service.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => FirebaseService.signOut().then((_) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
      }),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.logout),
          SizedBox(width: 8),
          Text('Sign out'),
        ],
      ),
    );
  }
}