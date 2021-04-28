import 'package:flutter/material.dart';

class ShopCategoryModel {
  static const ID = "id";
  static const BEGIN = 'begin';
  static const END = 'end';
  static const CATEGORY = 'category';
  static const IMAGE = 'image';

  String id;
  Color begin;
  Color end;
  String category;
  Icon image;

  ShopCategoryModel({this.id, this.begin, this.end, this.category, this.image});

  factory ShopCategoryModel.fromJson(Map<String, dynamic> json) {
    return ShopCategoryModel(
        id: json[ID],
        begin: json[BEGIN],
        end: json[END],
        category: json[CATEGORY],
        image: json[IMAGE]);
  }
}
