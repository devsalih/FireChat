import 'package:flutter/material.dart';

import 'firebase_service.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: () => FirebaseService.deleteUser().then((_) {
        Navigator.pushReplacementNamed(context, '/login');
      }),
      child: const Text('Delete account'),
    );
  }
}