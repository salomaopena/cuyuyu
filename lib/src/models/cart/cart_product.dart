// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/models/products/product.dart';
import 'package:flutter/cupertino.dart';

class CartProduct extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String id;
  String productId;
  int quantity;
  num fixedPrice;
  ProductModel _product;

  ProductModel get product => _product;
  set product(ProductModel value) {
    _product = value;
    notifyListeners();
  }

  CartProduct.fromProduct(this._product) {
    productId = product.id;
    quantity = 1;
  }

  CartProduct.fromDocument(DocumentSnapshot snapshot)
      : assert(snapshot != null) {
    id = snapshot.id;
    productId = snapshot.get('productId') as String;
    quantity = snapshot.get('quantity') as int;
    firestore.collection('Product').doc(productId).get().then((document) {
      product = ProductModel.fromDocument(document);
    });
  }

  num get unityPrice {
    if (product == null) return 0;
    return num.parse(product.price) ?? 0;
  }

  num get totalPrice => unityPrice * quantity;

  Map<String, dynamic> toCartItemMap() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }

  Map<String, dynamic> toOrderItemMap() {
    return {
      'productId': productId,
      'quantity': quantity,
      'fixedPrice': fixedPrice ?? unityPrice,
    };
  }

  CartProduct.fromMap(Map<String, dynamic> map) {
    productId = map['productId'] as String;
    quantity = map['quantity'] as int;
    fixedPrice = map['fixedPrice'] as num;
    firestore.doc('Product/$productId').get().then((document) {
      product = ProductModel.fromDocument(document);
    });
  }

  bool stackable(ProductModel product) {
    return product.id == productId;
  }

  void increment() {
    quantity++;
    notifyListeners();
  }

  void decrement() {
    quantity--;
    notifyListeners();
  }

  @override
  String toString() {
    return 'CartProduct{id: $id, productId: $productId, quantity: $quantity}';
  }
}
