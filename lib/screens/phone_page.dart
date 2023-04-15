import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import '../services/firebase_service.dart';

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
        FirebaseService.updateLastSignInTime();
        Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
      }),
      AuthStateChangeAction<UserCreated>((context, state) {
        FirebaseService.writeUser();
        Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
      }),
    ]);
  }
}
