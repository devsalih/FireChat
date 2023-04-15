import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/firechat_cubit.dart';
import '../services/firebase_service.dart';
import '../widgets/chat_bubble.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<FireChatCubit>();
    final user = cubit.selectedUser;
    final messages = cubit.messages;
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          user?.displayName ?? user?.email ?? user?.phoneNumber ?? 'Unknown',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(message: messages[index]);
                },
              ),
            ),
            ListTile(
              title: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Type a message',
                  border: OutlineInputBorder(),
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  FirebaseService.send(message: controller.text, to: user);
                  controller.clear();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

