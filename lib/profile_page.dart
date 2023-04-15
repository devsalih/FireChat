import 'package:flutter/material.dart';

import 'delete_account_button.dart';
import 'edit_display_name.dart';
import 'sign_out_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              SizedBox(height: 16.0),
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