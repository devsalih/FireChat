import 'package:flutter/material.dart';

import '../widgets/delete_account_button.dart';
import '../widgets/edit_display_name.dart';
import '../widgets/sign_out_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              EditDisplayName(),
              Spacer(),
              SignOutButton(),
              DeleteAccountButton(),
            ],
          ),
        ),
      ),
    );
  }
}