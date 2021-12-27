//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ProductCategory extends ChangeNotifier {
  String id;
  String name;
  String imageUrl;

  ProductCategory({this.id, this.name, this.imageUrl});

  ProductCategory.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    name = doc.get('name_product_category') as String;
    imageUrl = doc.get('image_url_product_category') as String;
  }

  Map<String, dynamic> toMap() {
    return {
      'name_product_category': name,
      'image_url_product_category': imageUrl,
    };
  }

  @override
  String toString() {
    return 'ProductCategory{id: $id, name: $name, imageUrl: $imageUrl}';
  }
}
