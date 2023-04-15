import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/firebase_service.dart';

class MessageModel {
  final String senderId;
  final String receiverId;
  final String text;
  final DateTime timestamp;
  final bool isRead;

  bool get isSent => senderId == FirebaseService.currentUser?.uid;

  String get uid => isSent ? receiverId : senderId;

  String get time {
    final now = DateTime.now();
    final diff = now.difference(timestamp);
    final dayString = timestamp.day.toString().padLeft(2, '0');
    final monthString = timestamp.month.toString().padLeft(2, '0');
    final yearString = timestamp.year.toString().padLeft(2, '0');
    final hourString = timestamp.hour.toString().padLeft(2, '0');
    final minuteString = timestamp.minute.toString().padLeft(2, '0');
    final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    if (now.weekday < timestamp.weekday || diff.inDays > 7) {
      return '$dayString.$monthString.$yearString';
    } else if (diff.inDays > 1) {
      return weekDays[timestamp.weekday - 1];
    } else if (now.day - timestamp.day == 1) {
      return 'Yesterday';
    } else {
      return '$hourString:$minuteString';
    }
  }

  String get hour {
    final hourString = timestamp.hour.toString().padLeft(2, '0');
    final minuteString = timestamp.minute.toString().padLeft(2, '0');
    return '$hourString:$minuteString';
  }

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.isRead,
    required this.timestamp,
  });

  factory MessageModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return MessageModel(
      senderId: data['senderId'],
      receiverId: data['receiverId'],
      text: data['text'],
      timestamp: data['timestamp'].toDate(),
      isRead: data['isRead'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'timestamp': timestamp,
      'isRead': isRead,
    };
  }
}
