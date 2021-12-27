//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/models/address/address_model.dart';
import 'package:cuyuyu/src/models/cart/cart_manager.dart';
import 'package:cuyuyu/src/models/cart/cart_product.dart';
import 'package:flutter/foundation.dart';

enum Status { canceled, preparing, transporting, delivered }
enum Payment { money, tpa, transfer }

class Order {
  String orderId;
  String payment;
  List<CartProduct> items = []..length;
  num price;
  String userId;
  AddressModel address;
  Timestamp date;
  Status status;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Order.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.user.userId;
    address = cartManager.address;
    status = Status.preparing;
  }

  Order.fromDocument(DocumentSnapshot doc) {
    orderId = doc.id;
    items = (doc.get('items') as List<dynamic>).map((e) {
      return CartProduct.fromMap(e as Map<String, dynamic>);
    }).toList();
    price = doc.get('price') as num;
    userId = doc.get('user') as String;
    address = AddressModel.fromMap(doc.get('address') as Map<String, dynamic>);
    date = doc.get('date') as Timestamp;
    status = Status.values[doc.get('status') as int];
    payment = doc.get('payment') as String;
  }

  void updateFromDocument(DocumentSnapshot doc) {
    status = Status.values[doc.get('status') as int];
  }

  Future<void> save() async {
    firestore.collection('orders').doc(orderId).set({
      'items': items.map((e) => e.toOrderItemMap()).toList(),
      'price': price,
      'user': userId,
      'address': address.toMap(),
      'status': status.index,
      'date': Timestamp.now(),
      'payment': payment,
    });
  }

  String get formattedId => '#${orderId.padLeft(6, '0')}';
  String get statusText => getStatusText(status);

  Function() get back {
    return status.index >= Status.transporting.index
        ? () {
            status = Status.values[status.index - 1];
            firestore
                .collection('orders')
                .doc(orderId)
                .update({'status': status.index});
          }
        : null;
  }

  Function() get advance {
    return status.index <= Status.transporting.index
        ? () {
            status = Status.values[status.index + 1];
            firestore
                .collection('orders')
                .doc(orderId)
                .update({'status': status.index});
          }
        : null;
  }

  Future<void> cancel() async {
    try {
      status = Status.canceled;
      firestore
          .collection('orders')
          .doc(orderId)
          .update({'status': status.index});
    } catch (error) {
      debugPrint('Erro ao cancelar');
      return Future.error('Falha ao cancelar');
    }
  }

  static String getStatusText(Status status) {
    switch (status) {
      case Status.canceled:
        return 'Cancelado';
      case Status.preparing:
        return 'Em preparação';
      case Status.transporting:
        return 'Em transporte';
      case Status.delivered:
        return 'Entregue';
      default:
        return '';
    }
  }

  static String getPaymentText(int position) {
    switch (Payment.values[position].index) {
      case 0:
        return 'Dinheiro';
      case 1:
        return 'TPA';
      case 2:
        return 'Transferência';
      default:
        return '';
    }
  }

  @override
  String toString() {
    return 'Order{orderId: $orderId, items: $items, price: $price, user: $userId, address: $address, date: $date}';
  }
}
