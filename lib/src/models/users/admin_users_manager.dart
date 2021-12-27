// @dart=2.9
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/models/users/user_manager.dart';
import 'package:cuyuyu/src/models/users/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AdminUsersManager extends ChangeNotifier {
  List<UserModel> users = []..length;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  StreamSubscription<dynamic> _streamSubscription;

  void updateUser(UserManager userManager) {
    _streamSubscription?.cancel();
    if (userManager.adminEnabled) {
      _listenToUsers();
    } else {
      users.clear();
      notifyListeners();
    }
  }

  void _listenToUsers() {
    _streamSubscription =
        firestore.collection('users').snapshots().listen((snapshots) {
      users = snapshots.docs.map((doc) => UserModel.fromDocument(doc)).toList();
      users.sort((a, b) =>
          a.userName.toLowerCase().compareTo(b.userName.toLowerCase()));
      notifyListeners();
    });
  }

  List<String> get names => users.map((e) => e.userName).toList();

  Future<void> deleteUserAccount(
      {UserModel userModel, Function onError}) async {
    try {
      await firestore.collection("users").doc(userModel.userId).delete();
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      onError(e);
    }
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
