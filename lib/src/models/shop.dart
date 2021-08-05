//@dart=2.9
import 'dart:convert';

Map<String, ShopModel> shopModelFromJson(String str) =>
    Map.from(json.decode(str))
        .map((k, v) => MapEntry<String, ShopModel>(k, ShopModel.fromJson(v)));

String shopModelToJson(Map<String, ShopModel> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class ShopModel {
  static const ID = "id";
  static const NAME = "name_shopping";
  static const LATITUDE = "latitude_shop";
  static const LOGITUDE = "longitude_shop";
  static const PHONE_NUMBER = "phone_number_shop";
  static const EMAIL = "email_shop";
  static const IMAGE = "image_url_shop";
  static const ADDRESS = "address_shop";
  static const OPEN_AT = "open_at_shop";
  static const CLOSE_AT = "close_at_shop";
  static const IS_OPEN = "is_open_shop";
  static const CATEGORY = "shop_category";

  ShopModel({
    this.id,
    this.addressShop,
    this.closeAtShop,
    this.emailShop,
    this.imageUrlShop,
    this.isOpenShop,
    this.latitudeShop,
    this.longitudeShop,
    this.nameShopping,
    this.openAtShop,
    this.phoneNumberShop,
    this.shopCategory,
  });

  String id;
  String addressShop;
  String closeAtShop;
  String emailShop;
  String imageUrlShop;
  String isOpenShop;
  String latitudeShop;
  String longitudeShop;
  String nameShopping;
  String openAtShop;
  String phoneNumberShop;
  String shopCategory;

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        id: json[ID],
        addressShop: json[ADDRESS],
        closeAtShop: json[CLOSE_AT],
        emailShop: json[EMAIL],
        imageUrlShop: json[IMAGE],
        isOpenShop: json[IS_OPEN],
        latitudeShop: json[LATITUDE],
        longitudeShop: json[LOGITUDE],
        nameShopping: json[NAME],
        openAtShop: json[OPEN_AT],
        phoneNumberShop: json[PHONE_NUMBER],
        shopCategory: json[CATEGORY],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address_shop": addressShop,
        "close_at_shop": closeAtShop,
        "email_shop": emailShop,
        "image_url_shop": imageUrlShop,
        "is_open_shop": isOpenShop,
        "latitude_shop": latitudeShop,
        "longitude_shop": longitudeShop,
        "name_shopping": nameShopping,
        "open_at_shop": openAtShop,
        "phone_number_shop": phoneNumberShop,
        "shop_category": shopCategory,
      };
}
