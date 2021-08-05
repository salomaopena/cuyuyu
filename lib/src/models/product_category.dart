//@dart=2.9
import 'package:flutter/cupertino.dart';

class ProductCategory {
  static const ID = "product_category_id";
  static const NAME = "name_product_category";
  static const IMAGE = "image_url_product_category";
  static const BEGIN = 'begin';
  static const END = 'end';

  String id;
  String name;
  Icon imageUrl;
  Color begin;
  Color end;

  ProductCategory({this.id, this.name, this.imageUrl, this.begin, this.end});
}
