import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timestamp;
  final bool isRead;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
    required this.isRead,
  });

  factory MessageModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return MessageModel(
      id: doc.id,
      senderId: data['senderId'],
      receiverId: data['receiverId'],
      message: data['message'],
      timestamp: data['timestamp'].toDate(),
      isRead: data['isRead'],
    );
  }
}