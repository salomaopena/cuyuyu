//@dart=2.9
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/models/orders/order.dart';
import 'package:cuyuyu/src/models/users/user_model.dart';
import 'package:flutter/foundation.dart';

class AdminOrdersManager extends ChangeNotifier {
  final List<Order> _orders = []..length;
  UserModel userFilter;
  List<Status> statusFiltered = [Status.preparing];
  StreamSubscription _subscription;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateAdmin({bool adminEnabled}) {
    _orders.clear();
    _subscription?.cancel();
    if (adminEnabled) {
      _listenToOrders();
    }
  }

  List<Order> get filteredOrders {
    List<Order> output = _orders.reversed.toList();
    if (userFilter != null) {
      output =
          output.where((order) => order.userId == userFilter.userId).toList();
    }
    return output
        .where((order) => statusFiltered.contains(order.status))
        .toList();
  }

  void _listenToOrders() {
    _subscription = firestore.collection('orders').snapshots().listen((event) {
      for (final change in event.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            _orders.add(Order.fromDocument(change.doc));
            break;
          case DocumentChangeType.modified:
            final modOrder =
                _orders.firstWhere((order) => order.orderId == change.doc.id);
            modOrder.updateFromDocument(change.doc);
            break;
          case DocumentChangeType.removed:
            debugPrint('Ocorreu um erro grave!');
            break;
        }
      }
      notifyListeners();
    });
  }

  void setUserFilter(UserModel user) {
    userFilter = user;
    notifyListeners();
  }

  void setStatusFilter({Status status, bool enabled}) {
    if (enabled) {
      statusFiltered.add(status);
    } else {
      statusFiltered.remove(status);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
