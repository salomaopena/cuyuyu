//@dart=2.9
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/models/orders/order.dart';
import 'package:cuyuyu/src/models/users/user_model.dart';
import 'package:flutter/foundation.dart';

class OrdersManager extends ChangeNotifier {
  UserModel user = UserModel();
  List<Order> orders = []..length;
  StreamSubscription _subscription;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateUser(UserModel user) {
    this.user = user;
    orders.clear();
    _subscription?.cancel();
    if (user != null) {
      _listenToOrders();
    }
  }

  void _listenToOrders() {
    _subscription = firestore
        .collection('orders')
        .where('user', isEqualTo: user.userId)
        .snapshots()
        .listen((event) {
      orders.clear();
      for (final doc in event.docs) {
        orders.add(Order.fromDocument(doc));
      }
      notifyListeners();
    });
  }


  static String timeAgoSinceDate(String dateString,
      {bool numericDates = true}) {
    DateTime date = DateTime.parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if ((difference.inDays / 365).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} anos atrás';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return (numericDates) ? '1 ano atrás' : 'ano anterior';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} meses atrás';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates) ? '1 mês atrás' : 'último mês';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return '${(difference.inDays / 7).floor()} semanas atrás';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 semana atrás' : 'última semana';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} dias atrás';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 dia atrás' : 'ontem';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} horas atrás';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hora atrás' : 'Uma hora atrás';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutos atrás';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minuto atrás' : 'Um minuto atrás';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} segundos atrás';
    } else {
      return 'Agora';
    }
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
