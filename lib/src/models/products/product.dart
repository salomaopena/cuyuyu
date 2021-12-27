//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ProductModel extends ChangeNotifier{
  static const ID = "product_id";
  static const PRODUCT_NAME = "name_product";
  static const IMAGE_URL = "image_url_product";
  static const DESCRIPTION = "description_product";
  static const VARIATION_ID = "variation_id";
  static const CATEGORY = "product_category_id";
  static const UNIT = "unity_id";
  static const OLD_PRICE = "old_price_product";
  static const PRICE = "price_product";
  static const DISCOUNT = "discount_product";
  static const IVA = "iva_product";
  static const DISPONIBILITY = "is_disponible";
  static const FUTURED = "featured_product";
  static const MINIMUM = "minimum_number_product";
  static const SHOP_ID = "id_shop";
  static const NAME_SHOPPING = "name_shopping";
  static const STAR_COUNT = "start_count_product";
  static const FRETE = "frete";

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
  num iva;
  bool isDisponible;
  bool featured;
  num minimumNumber;
  num startCount;
  String shop;
  String nameShopping;
  String frete;

  ProductModel(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.variation,
      this.category,
      this.unity,
      this.oldPrice,
      this.price,
      this.discount,
      this.iva,
      this.isDisponible,
      this.featured,
      this.minimumNumber,
      this.startCount,
      this.shop,
      this.nameShopping,
      this.frete});

  ProductModel.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    name = snapshot.get(PRODUCT_NAME) as String;
    image = snapshot.get(IMAGE_URL) as String;
    description = snapshot.get(DESCRIPTION) as String;
    variation = snapshot.get(VARIATION_ID) as String;
    category = snapshot.get(CATEGORY) as String;
    unity = snapshot.get(UNIT) as String;
    oldPrice = snapshot.get(OLD_PRICE) as String;
    price = snapshot.get(PRICE) as String;
    discount = snapshot.get(DISCOUNT) as String;
    iva = snapshot.get(IVA) as num;
    isDisponible = snapshot.get(DISPONIBILITY) as bool;
    featured = snapshot.get(FUTURED) as bool;
    minimumNumber = snapshot.get(MINIMUM) as num;
    startCount = snapshot.get(STAR_COUNT) as num;
    shop = snapshot.get(SHOP_ID) as String;
    frete = snapshot.get(FRETE) as String;
  }

  double get basePrice => double.parse(price);

  @override
  String toString() {
    return 'ProductModel{id: $id, name: $name, image: $image, description: $description, variation: $variation, category: $category, unity: $unity, oldPrice: $oldPrice, price: $price, discount: $discount, iva: $iva, isDisponible: $isDisponible, featured: $featured, minimumNumber: $minimumNumber, startCount: $startCount, shop: $shop, nameShopping: $nameShopping, frete: $frete}';
  }
}
