import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/firechat_cubit.dart';
import '../widgets/user_tile.dart';

class NewMessagePage extends StatefulWidget {
  const NewMessagePage({Key? key}) : super(key: key);

  @override
  State<NewMessagePage> createState() => _NewMessagePageState();
}

class _NewMessagePageState extends State<NewMessagePage> {
  String _name = '';

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<FireChatCubit>();
    final users = cubit.searchUsers(_name);
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Message'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _name = value),
            ),
            ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return UserTile(
                  user: user,
                  onTap: () {
                    cubit.selectUser(user);
                    Navigator.popAndPushNamed(context, '/chat');
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
