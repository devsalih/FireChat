import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> signInAnonymously() async {
    await _auth.signInAnonymously();
  }

  static Future<void> signOut() async => await _auth.signOut();
}
