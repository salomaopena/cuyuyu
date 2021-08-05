//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  static const BANNER_TITLE = "title";
  static const BANNER_OFFER = "offer";
  static const BANNER_URL = "image_url";
  static const SHOP_ID = "shop_id";
  static const CREATED = "created";
  static const DAYS = "days";

  String bannerId;
  String title;
  String offer;
  String imageUrl;
  String shopId;
  Timestamp created;
  int days;

  BannerModel(
      {this.bannerId,
      this.title,
      this.offer,
      this.imageUrl,
      this.shopId,
      this.created,
      this.days});

  factory BannerModel.fromDocument(DocumentSnapshot snapshot) {
    return BannerModel(
        bannerId: snapshot.id,
        title: snapshot.data()[BANNER_TITLE],
        offer: snapshot.data()[BANNER_OFFER],
        imageUrl: snapshot.data()[BANNER_URL],
        shopId: snapshot.data()[SHOP_ID],
        created: snapshot.data()[CREATED],
        days: snapshot.data()[DAYS]);
  }
}
