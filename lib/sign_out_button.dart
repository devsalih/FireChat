import 'package:flutter/material.dart';

import 'firebase_service.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => FirebaseService.signOut().then((_) {
        Navigator.pushReplacementNamed(context, '/login');
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