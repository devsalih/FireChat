import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class PhonePage extends StatelessWidget {
  const PhonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhoneInputScreen(actions: [
      SMSCodeRequestedAction((context, action, flowKey, phoneNumber) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SMSCodeInputScreen(flowKey: flowKey),
        ));
      }),
      AuthStateChangeAction<SignedIn>((context, state) {
        Navigator.pushReplacementNamed(context, '/profile');
      }),
      AuthStateChangeAction<UserCreated>((context, state) {
        Navigator.pushReplacementNamed(context, '/profile');
      }),
    ]);
  }
}
