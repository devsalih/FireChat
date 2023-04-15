import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/firechat_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<FireChatCubit>().getMessages();
    context.read<FireChatCubit>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () => Navigator.pushNamed(context, '/profile'),
        ),
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/new_message');
            },
          ),
        ],
      ),
      body: BlocBuilder<FireChatCubit, FireChatState>(
        builder: (context, state) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: state.latestMessages.length,
            itemBuilder: (context, index) {
              final message = state.latestMessages[index];
              final user = context.read<FireChatCubit>().getUser(message.uid);
              return ListTile(
                leading: CircleAvatar(
                  child: Text((user.displayName ?? '')[0]),
                ),
                title: Text(user.displayName ?? ''),
                subtitle: Text(message.text),
                onTap: () {
                  context.read<FireChatCubit>().selectUser(user);
                  Navigator.pushNamed(context, '/chat');
                },
              );
            },
          );
        },
      ),
    );
  }
}
