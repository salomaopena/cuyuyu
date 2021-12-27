// ignore_for_file: strict_raw_type, unnecessary_null_comparison, import_of_legacy_library_into_null_safe
//@dart=2.9
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/models/notification/notifications.dart';
import 'package:cuyuyu/src/models/users/user_model.dart';
import 'package:flutter/foundation.dart';

class NotificationsManager extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Notifications> notifications = []..length;
  UserModel user = UserModel();
  StreamSubscription _subscription;

  bool _loading = false;
  bool get loading => _loading;

  void updateUser(UserModel user) {
    this.user = user;
    notifications.clear();
    _subscription?.cancel();
    if (user != null) {
      _loadANotifications();
    }
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void _loadANotifications() {
    _subscription = firestore
        .collection('notifications')
        .where('user', isEqualTo: user.userId)
        .orderBy('date', descending: true)
        .snapshots()
        .listen((event) {
      notifications.clear();
      for (final doc in event.docs) {
        notifications.add(Notifications.fromDocument(doc));
      }
      notifyListeners();
    });
  }

  Future<void> deleteNotifications({String id}) async {
    loading = true;
    await firestore.doc('notifications/$id').delete().whenComplete(() {
      notifyListeners();
      loading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
