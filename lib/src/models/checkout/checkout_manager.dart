//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/models/cart/cart_manager.dart';
import 'package:cuyuyu/src/models/orders/order.dart';
import 'package:flutter/foundation.dart';

class CheckoutManager extends ChangeNotifier {
  CartManager cartManager;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<String> pymentList = []..length;
  String payment;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> updateCart(CartManager cartManager) async {
    this.cartManager = cartManager;
  }

  Future<void> checkout({Function onStockFail, Function onSuccess}) async {
    loading = true;
    final int orderId = await _getOrderId();
    final Order order = Order.fromCartManager(cartManager);

    order.payment = payment ?? "Dinheiro";

    order.orderId = orderId.toString();

    await order.save();

    cartManager.clear();

    onSuccess(order);
    loading = false;
  }

  Future<int> _getOrderId() async {
    final ref = firestore.doc('config/ordercounter');
    try {
      final result = await firestore.runTransaction((ts) async {
        final doc = await ts.get(ref);
        final orderId = doc.get('current') as int;
        await ts.update(ref, {'current': orderId + 1});
        return {'orderId': orderId};
      });
      return result['orderId'] as int;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error('Falha ao gerar número');
    }
  }
}
