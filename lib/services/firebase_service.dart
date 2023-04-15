import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firechat/models/message_model.dart';

import '../models/user_model.dart';

class FirebaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final _db = FirebaseFirestore.instance;
  static final _usersRef = _db.collection('users');
  static final _messagesRef = _db.collection('messages');
  static final _currentUserRef = _usersRef.doc(_auth.currentUser?.uid);

  static User? get currentUser => _auth.currentUser;

  static Future<void> send({
    required String message,
    required UserModel? to,
  }) async {
    final user = currentUser;
    if (user == null || to == null) return;
    final messageRef = _messagesRef.doc();
    final batch = _db.batch();
    Map<String, dynamic> map = MessageModel(
      senderId: user.uid,
      receiverId: to.uid,
      text: message,
      timestamp: DateTime.now(),
      isRead: false,
    ).toMap();
    batch.set(messageRef, map);
    batch.set(_currentUserRef.collection('chats').doc(to.uid), map);
    batch.set(_usersRef.doc(to.uid).collection('chats').doc(user.uid), map);
    await batch.commit();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getMessages() {
    return _messagesRef.orderBy('timestamp', descending: false).snapshots();
  }

  static void writeUser() {
    final user = currentUser;
    if (user == null) return;
    _currentUserRef.set({
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
    _currentUserRef.update({
      'lastSignInTime': DateTime.now(),
      'isOnline': true,
    });
  }

  static void updateOnlineStatus(bool isOnline) {
    final uid = currentUser?.uid;
    if (uid == null) return;
    _currentUserRef.update({
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
    await _currentUserRef.delete();
  }

  static Future<void> updateDisplayName(String name) async {
    final user = currentUser;
    if (user == null) return;
    if (name == user.displayName || name.isEmpty) return;
    await _currentUserRef.update({'displayName': name});
    await user.updateDisplayName(name);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
    return _usersRef.snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getMyMessages() {
    return _currentUserRef.collection('chats').snapshots();
  }

  static Future<List<MessageModel>> getLatestMessages() async {
    final user = currentUser;
    if (user == null) return [];
    return await _currentUserRef.collection('chats').get().then((snapshot) {
      return snapshot.docs.map((e) => MessageModel.fromDocument(e)).toList();
    });
  }

  static Future<void> signOut() async {
    updateOnlineStatus(false);
    await _auth.signOut();
  }
}
