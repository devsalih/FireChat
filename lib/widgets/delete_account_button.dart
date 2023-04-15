import 'package:flutter/material.dart';

import '../services/firebase_service.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: () => FirebaseService.deleteUser().then((_) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
      }),
      child: const Text('Delete account'),
    );
  }
}