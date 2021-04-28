import 'package:cuyuyu/src/utils/databases/database_app.dart';
import 'package:flutter/foundation.dart';

class CartModel {
  int cartId;
  String cartProdId;
  String cartName;
  String image;
  String cartDescription;
  String cartVariation;
  String cartUnity;
  String cartPrice;
  String cartDiscount;
  String cartIva;
  String cartQuantity;
  String shop;
  String nameShopping;
  String frete;

  CartModel(
      {@required this.cartId,
      @required this.cartProdId,
      @required this.cartName,
      this.image,
      this.cartDescription,
      this.cartVariation,
      this.cartUnity,
      @required this.cartPrice,
      this.cartDiscount,
      this.cartIva,
      @required this.cartQuantity,
      this.shop,
        this.nameShopping,
      this.frete});

  CartModel.fromMap(Map<String, dynamic> map) {
    cartId = map[DatabaseApp.id];
    cartProdId = map[DatabaseApp.prodId];
    cartName = map[DatabaseApp.name];
    image = map[DatabaseApp.image];
    cartDescription = map[DatabaseApp.description];
    cartVariation = map[DatabaseApp.variation];
    cartUnity = map[DatabaseApp.unity];
    cartPrice = map[DatabaseApp.price];
    cartDiscount = map[DatabaseApp.discount];
    cartIva = map[DatabaseApp.iva];
    cartQuantity = map[DatabaseApp.quantity];
    shop = map[DatabaseApp.shop];
    nameShopping = map[DatabaseApp.nameShopping];
    frete = map[DatabaseApp.frete];
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseApp.id: cartId,
      DatabaseApp.prodId: cartProdId,
      DatabaseApp.name: cartName,
      DatabaseApp.image: image,
      DatabaseApp.description: cartDescription,
      DatabaseApp.variation: cartVariation,
      DatabaseApp.unity: cartUnity,
      DatabaseApp.price: cartPrice,
      DatabaseApp.discount: cartDiscount,
      DatabaseApp.iva: cartIva,
      DatabaseApp.quantity: cartQuantity,
      DatabaseApp.shop: shop,
      DatabaseApp.nameShopping:nameShopping,
      DatabaseApp.frete: frete,
    };
  }
}
