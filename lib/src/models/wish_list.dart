//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/utils/databases/database_app.dart';
import 'package:flutter/foundation.dart';

class WishListModel {
  int wishId;
  String id;
  String name;
  String image;
  String description;
  String variation;
  String category;
  String unity;
  String oldPrice;
  String price;
  String discount;
  String iva;
  String isDisponible;
  String featured;
  String minimumNumber;
  String startCount;
  String shop;
  String frete;

  WishListModel(
      {@required this.wishId,
      @required this.id,
      @required this.name,
      this.image,
      this.description,
      this.variation,
      this.category,
      this.unity,
      this.oldPrice,
      @required this.price,
      @required this.discount,
      this.iva,
      this.isDisponible,
      this.featured,
      @required this.minimumNumber,
      this.startCount,
      this.shop,
      this.frete});

  WishListModel.fromMap(Map<String, dynamic> map) {
    wishId = map[DatabaseApp.wishId];
    id = map[DatabaseApp.productId];
    name = map[DatabaseApp.productName];
    image = map[DatabaseApp.imageUrl];
    description = map[DatabaseApp.productDescr];
    variation = map[DatabaseApp.productVaria];
    category = map[DatabaseApp.category];
    unity = map[DatabaseApp.productUnit];
    oldPrice = map[DatabaseApp.productOldPrice];
    price = map[DatabaseApp.productPrice];
    discount = map[DatabaseApp.productDiscount];
    iva = map[DatabaseApp.productIva].toString();
    isDisponible = map[DatabaseApp.disponibility].toString();
    featured = map[DatabaseApp.prductFeatured].toString();
    minimumNumber = map[DatabaseApp.productMinimum].toString();
    startCount = map[DatabaseApp.productStarCount].toString();
    shop = map[DatabaseApp.productShop];
    frete = map[DatabaseApp.productFrete];
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseApp.wishId: wishId,
      DatabaseApp.productId: id,
      DatabaseApp.productName: name,
      DatabaseApp.imageUrl: image,
      DatabaseApp.productDescr: description,
      DatabaseApp.productVaria: variation,
      DatabaseApp.category: category,
      DatabaseApp.productUnit: unity,
      DatabaseApp.productOldPrice: oldPrice,
      DatabaseApp.productPrice: price,
      DatabaseApp.productDiscount: discount,
      DatabaseApp.productIva: iva,
      DatabaseApp.disponibility: isDisponible,
      DatabaseApp.prductFeatured: featured,
      DatabaseApp.productMinimum: minimumNumber,
      DatabaseApp.productStarCount: startCount,
      DatabaseApp.productShop: shop,
      DatabaseApp.productFrete: frete
    };
  }

  factory WishListModel.fromDocument(DocumentSnapshot snapshot) {
    return WishListModel(
      wishId: snapshot.data()[DatabaseApp.wishId],
        id: snapshot.data()[DatabaseApp.productId],
        name: snapshot.data()[DatabaseApp.productName],
        image: snapshot.data()[DatabaseApp.imageUrl],
        description: snapshot.data()[DatabaseApp.productDescr],
        variation: snapshot.data()[DatabaseApp.productVaria],
        category: snapshot.data()[DatabaseApp.category],
        unity: snapshot.data()[DatabaseApp.productUnit],
        oldPrice: snapshot.data()[DatabaseApp.productOldPrice],
        price: snapshot.data()[DatabaseApp.productPrice],
        discount: snapshot.data()[DatabaseApp.productDiscount],
        iva: snapshot.data()[DatabaseApp.productIva],
        isDisponible: snapshot.data()[DatabaseApp.disponibility],
        featured: snapshot.data()[DatabaseApp.prductFeatured],
        minimumNumber: snapshot.data()[DatabaseApp.productMinimum],
        startCount: snapshot.data()[DatabaseApp.productStarCount],
        shop: snapshot.data()[DatabaseApp.productShop],
        frete: snapshot.data()[DatabaseApp.productFrete]);
  }
}
