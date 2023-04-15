import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final db = FirebaseFirestore.instance;

  static User? get currentUser => _auth.currentUser;

  static String? get _uid => currentUser?.uid;

  static String? get displayName => currentUser?.displayName;

  static void writeUser() {
    final user = currentUser;
    if (user == null) return;
    db.collection('users').doc(user.uid).set({
      'email': user.email,
      'displayName': user.displayName,
      'phoneNumber': user.phoneNumber,
      'isAnonymous': user.isAnonymous,
      'isEmailVerified': user.emailVerified,
      'isOnline': true,
      'lastSignInTime': DateTime.now(),
      'creationTime': DateTime.now(),
    });
  }

  static void updateLastSignInTime() {
    final user = currentUser;
    if (user == null) return;
    db.collection('users').doc(user.uid).update({
      'lastSignInTime': DateTime.now(),
      'isOnline': true,
    });
  }

  static void updateOnlineStatus(bool isOnline) {
    final uid = _uid;
    if (uid == null) return;
    db.collection('users').doc(uid).update({
      'isOnline': isOnline,
      'lastSeen': isOnline ? null : DateTime.now(),
    });
  }

  static Future<void> signInAnonymously() async {
    await _auth.signInAnonymously();
    writeUser();
  }

  static Future<void> deleteUser() async {
    final user = currentUser;
    if (user == null) return;
    await user.delete();
    await db.collection('users').doc(user.uid).delete();
  }

  static Future<void> updateDisplayName(String name) async {
    final user = currentUser;
    if (user == null) return;
    if (name == user.displayName || name.isEmpty) return;
    await db.collection('users').doc(user.uid).update({'displayName': name});
    await user.updateDisplayName(name);
  }

  static Future<void> signOut() async {
    updateOnlineStatus(false);
    await _auth.signOut();
  }
}
