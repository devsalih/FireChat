import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'email_verification_page.dart';
import 'firebase_options.dart';
import 'login_page.dart';
import 'phone_page.dart';
import 'profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    PhoneAuthProvider(),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FireChat',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: currentUser == null
          ? '/login'
          : currentUser.emailVerified || currentUser.phoneNumber != null
              ? '/profile'
              : '/verify',
      routes: {
        '/login': (context) => const LoginPage(),
        '/profile': (context) => const ProfilePage(),
        '/verify': (context) => const EmailVerificationPage(),
        '/phone': (context) => const PhonePage(),
      },
    );
  }
}
