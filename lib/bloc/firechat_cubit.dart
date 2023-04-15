import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/message_model.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';

class FireChatCubit extends Cubit<FireChatState> {
  FireChatCubit() : super(FireChatState());

  void getUsers() {
    FirebaseService.getUsers().listen((event) {
      final users = event.docs.map((e) => UserModel.fromDocument(e)).toList();
      emit(state.copyWith(users: users));
    });
  }

  getMessages() {
    FirebaseService.getMessages().listen((event) {
      final messages = event.docs
          .map((e) => MessageModel.fromDocument(e))
          .where((e) => [e.senderId, e.receiverId]
              .contains(FirebaseService.currentUser?.uid))
          .toList();
      emit(state.copyWith(messages: messages));
    });

    FirebaseService.getMyMessages().listen((event) {
      final latestMessages = event.docs.map((e) {
        return MessageModel.fromDocument(e);
      }).toList();
      emit(state.copyWith(latestMessages: latestMessages));
    });
  }

  void selectUser(UserModel user) => emit(state.copyWith(selectedUser: user));

  UserModel? get selectedUser => state.selectedUser;

  List<MessageModel> get latestMessages => state.latestMessages;

  List<MessageModel> get messages {
    if (selectedUser == null) return state.messages;
    return state.messages.where((e) {
      return [e.senderId, e.receiverId].contains(selectedUser?.uid);
    }).toList();
  }

  UserModel getUser(String uid) => state.users.firstWhere((e) => e.uid == uid);

  List<UserModel> get users {
    return state.users.where((e) {
      return e.uid != FirebaseService.currentUser?.uid;
    }).toList();
  }

  List<UserModel> searchUsers(String query) {
    return state.users.where((e) {
      print('${e.uid} ${FirebaseService.currentUser?.uid}');
      final name = e.displayName?.toLowerCase() ?? '';
      final email = e.email?.toLowerCase() ?? '';
      final phone = e.phoneNumber?.toLowerCase() ?? '';
      final info = '$name$email$phone'.replaceAll(' ', '');
      final search = query.toLowerCase().replaceAll(' ', '');
      return info.contains(search);
    }).toList();
  }
}

class FireChatState {
  List<UserModel> users = [];
  List<MessageModel> messages = [];
  List<MessageModel> latestMessages = [];
  UserModel? selectedUser;

  FireChatState({
    this.users = const [],
    this.messages = const [],
    this.latestMessages = const [],
    this.selectedUser,
  });

  FireChatState copyWith({
    List<UserModel>? users,
    List<MessageModel>? messages,
    List<MessageModel>? latestMessages,
    UserModel? selectedUser,
  }) {
    return FireChatState(
      users: users ?? this.users,
      messages: messages ?? this.messages,
      latestMessages: latestMessages ?? this.latestMessages,
      selectedUser: selectedUser ?? this.selectedUser,
    );
  }
}
