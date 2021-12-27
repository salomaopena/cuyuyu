//@dart
import 'package:cuyuyu/src/models/orders/order.dart';
import 'package:flutter/material.dart';

extension Extra on TimeOfDay {
  String formatedTime() {
    return '${hour}h:${minute.toString().padLeft(2, '0')}';
  }

  int toMinutes() => hour * 60 + minute;
}
