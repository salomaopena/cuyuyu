//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
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

  BannerModel.fromDocument(DocumentSnapshot snapshot) {
    bannerId = snapshot.id;
    title = snapshot.get('title') as String;
    offer = snapshot.get('offer') as String;
    imageUrl = snapshot.get('image_url') as String;
    shopId = snapshot.get('shop_id') as String;
    created = snapshot.get('created') as Timestamp;
    days = snapshot.get('days') as int;
  }

  @override
  String toString() {
    return 'BannerModel{bannerId: $bannerId, title: $title, offer: $offer, imageUrl: $imageUrl, shopId: $shopId, created: $created, days: $days}';
  }
}
