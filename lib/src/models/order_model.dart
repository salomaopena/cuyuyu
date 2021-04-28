import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'cart_model.dart';

class OrderModel {
  static const ORDER_ID = "orderId";
  static const USER_ID = "userId";
  static const USER_NAME = "userName";
  static const USER_PHONE = "userPhone";
  static const USER_MAIL = "userEmail";
  static const USER_ADDRESS = "userAddress";
  static const ORDER_DETAIL = "orderDetail";
  static const FRETE = "frete";
  static const ORDER_ADRESS = "orderAddress";
  static const ORDER_DATE = "orderDate";
  static const PAYMENT = "orderPaymentMethod";
  static const STATUS = "orderStatus";
  static const COMMENT = "orderComment";
  static const SUBTOTAL = "subtotal";
  static const TOTAL = "total";

  String orderId;
  String userId;
  String userName;
  String userPhone;
  String userEmail;
  String userAddress;
  List<CartModel> orderDetail = new List<CartModel>();
  double frete;
  String orderAddress;
  Timestamp orderDate;
  String orderPaymentMethod;
  String orderStatus;
  String orderComment;
  double subtotal;
  double total;

  OrderModel(
      {@required this.orderId,
      @required this.userId,
      @required this.userName,
      @required this.userPhone,
      this.userEmail,
      @required this.userAddress,
      this.orderDetail,
      this.frete,
      this.orderAddress,
      this.orderDate,
      @required this.orderPaymentMethod,
      @required this.orderStatus,
      this.orderComment,
      this.subtotal,
      this.total});

  factory OrderModel.fromDocument(DocumentSnapshot snapshot) {
    return OrderModel(
        orderId: snapshot.id,
        userId: snapshot.data()[USER_ID],
        userName: snapshot.data()[USER_NAME],
        userPhone: snapshot.data()[USER_PHONE],
        userEmail: snapshot.data()[USER_MAIL],
        userAddress: snapshot.data()[USER_ADDRESS],
        orderDetail: snapshot.data()[ORDER_DETAIL],
        frete: snapshot.data()[FRETE],
        orderAddress: snapshot.data()[ORDER_ADRESS],
        orderDate: snapshot.data()[ORDER_DATE],
        orderPaymentMethod: snapshot.data()[PAYMENT],
        orderStatus: snapshot.data()[STATUS],
        orderComment: snapshot.data()[COMMENT],
        subtotal: snapshot.data()[SUBTOTAL],
        total: snapshot.data()[TOTAL]);
  }

  OrderModel.fromMap(Map<String, dynamic> map) {
    this.orderId = map[ORDER_ID];
    this.userId = map[USER_ID];
    this.userName = map[USER_NAME];
    this.userPhone = map[USER_PHONE];
    this.userEmail = map[USER_MAIL];
    this.userAddress = map[USER_ADDRESS];
    this.orderDetail = List.from(map[ORDER_DETAIL]);
    this.frete = map[FRETE];
    this.orderAddress = map[ORDER_ADRESS];
    this.orderDate = map[ORDER_DATE];
    this.orderPaymentMethod = map[PAYMENT];
    this.orderStatus = map[STATUS];
    this.orderComment = map[COMMENT];
    this.subtotal = map[SUBTOTAL];
    this.total = map[TOTAL];

    if (map[ORDER_DETAIL] == null) {
      this.orderDetail = new List<CartModel>();
    } else {
      this.orderDetail =
          (map[ORDER_DETAIL] as List).map((i) => CartModel.fromMap(i)).toList();
    }
  }

  Map<String, dynamic> toMap() {
    return {
      ORDER_ID: orderId,
      USER_ID: userId,
      USER_NAME: userName,
      USER_PHONE: userPhone,
      USER_MAIL: userEmail,
      USER_ADDRESS: userAddress,
      ORDER_DETAIL: orderDetail,
      FRETE: frete,
      ORDER_ADRESS: orderAddress,
      ORDER_DATE: orderDate,
      PAYMENT: orderPaymentMethod,
      STATUS: orderStatus,
      COMMENT: orderComment,
      SUBTOTAL: subtotal,
      TOTAL: total,
    };
  }
}
