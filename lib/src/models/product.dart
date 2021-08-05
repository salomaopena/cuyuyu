//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
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
  double oldPrice;
  double price;
  double discount;
  double iva;
  String isDisponible;
  String featured;
  double minimumNumber;
  double startCount;
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

  ProductModel.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        id = snapshot.id,
        name = snapshot.data()[PRODUCT_NAME],
        image = snapshot.data()[IMAGE_URL],
        description = snapshot.data()[DESCRIPTION],
        variation = snapshot.data()[VARIATION_ID],
        category = snapshot.data()[CATEGORY],
        unity = snapshot.data()[UNIT],
        oldPrice = snapshot.data()[OLD_PRICE],
        price = snapshot.data()[PRICE],
        discount = snapshot.data()[DISCOUNT],
        iva = snapshot.data()[IVA],
        isDisponible = snapshot.data()[DISPONIBILITY],
        featured = snapshot.data()[FUTURED],
        minimumNumber = snapshot.data()[MINIMUM],
        startCount = snapshot.data()[STAR_COUNT],
        shop = snapshot.data()[SHOP_ID],
        nameShopping = snapshot.data()[NAME_SHOPPING],
        frete = snapshot.data()[FRETE];
}
