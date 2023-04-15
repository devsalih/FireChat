import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserTile extends StatelessWidget {
  final VoidCallback onTap;
  final UserModel user;

  const UserTile({Key? key, required this.user, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(user.displayName ?? 'Anonymous'),
      subtitle: Text(user.email ?? user.phoneNumber ?? 'Anonymous'),
      leading: CircleAvatar(
        child: Text(user.displayName?.substring(0, 1) ?? '?'),
      ),
      trailing: CircleAvatar(
        radius: 5,
        backgroundColor: user.isOnline ? Colors.green : Colors.black12,
      ),
    );
  }
}
