import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String? email;
  final String? displayName;
  final String? phoneNumber;
  final bool isAnonymous;
  final bool isEmailVerified;
  final DateTime lastSignInTime;
  final DateTime creationTime;
  final bool isOnline;
  final DateTime? lastSeen;

  UserModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.phoneNumber,
    required this.isAnonymous,
    required this.isEmailVerified,
    required this.lastSignInTime,
    required this.creationTime,
    required this.isOnline,
    this.lastSeen,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      email: data['email'],
      displayName: data['displayName'],
      phoneNumber: data['phoneNumber'],
      isAnonymous: data['isAnonymous'],
      isEmailVerified: data['isEmailVerified'],
      lastSignInTime: data['lastSignInTime'].toDate(),
      creationTime: data['creationTime'].toDate(),
      isOnline: data['isOnline'],
      lastSeen: data['lastSeen']?.toDate(),
    );
  }
}