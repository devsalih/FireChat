import 'package:flutter/material.dart';

import 'firebase_service.dart';

class EditDisplayName extends StatefulWidget {
  const EditDisplayName({Key? key}) : super(key: key);

  @override
  State<EditDisplayName> createState() => _EditDisplayNameState();
}

class _EditDisplayNameState extends State<EditDisplayName> {
  String _name = FirebaseService.displayName ?? '';
  final _controller = TextEditingController(text: FirebaseService.displayName);
  final _node = FocusNode();
  bool _editing = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextField(
          focusNode: _node,
          controller: _controller,
          decoration: const InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => setState(() => _name = value),
          enabled: _editing,
        ),
        IconButton(
          icon: Icon(_editing ? Icons.check : Icons.edit),
          onPressed: () {
            if (_editing) FirebaseService.updateDisplayName(_name);
            setState(() => _editing = !_editing);
          },
        ),
      ],
    );
  }
}