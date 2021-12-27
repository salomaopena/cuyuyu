//@dart=2.9
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/models/chat/chat_model.dart';
import 'package:cuyuyu/src/models/users/user_model.dart';
import 'package:flutter/foundation.dart';

class ChatManager extends ChangeNotifier {
  UserModel user = UserModel();
  ChatModel chat = ChatModel();
  List<ChatModel> messages = []..length;
  StreamSubscription _subscription;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  updateUser(UserModel user) {
    this.user = user;
    messages.clear();
    _subscription?.cancel();
    if (user != null) {
      _listenToChat();
    }
  }

  void _listenToChat() {
    _subscription = firestore
        .collection('Chat')
        .doc(user.userId)
        .collection('messages')
        .snapshots()
        .listen((event) {
      messages.clear();
      for (final doc in event.docs) {
        messages.add(ChatModel.fromDocument(doc));
      }
      notifyListeners();
    });
  }

  Future<void> sendMessage(UserModel userModel, String message) async {
    user = userModel;
    chat = ChatModel(message: message);
    await chat.send(user);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
