//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/models/products/product.dart';
import 'package:flutter/foundation.dart';

class ProductManager extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<ProductModel> allProducts = []..length;

  String _search = '';
  String get search => _search;

  ProductManager() {
    _loadAllProducts();
  }
  set search(String value) {
    _search = value;
    notifyListeners();
  }

  Future<void> _loadAllProducts() async {
    final QuerySnapshot querySnapshotProducts =
        await firestore.collection("Product").limit(50).get();
    allProducts = querySnapshotProducts.docs
        .map((doc) => ProductModel.fromDocument(doc))
        .toList();
    notifyListeners();
  }

  List<ProductModel> get filteredProducts {
    final List<ProductModel> filteredProducts = []..length;
    if (search.isEmpty) {
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(allProducts.where((ProductModel produto) =>
          produto.name.toLowerCase().contains(search.toLowerCase())));
    }
    return filteredProducts;
  }

  List<ProductModel> filteredProductsByCategory(String category) {
    final List<ProductModel> filteredProducts = []..length;
    if (search.isEmpty) {
      filteredProducts
          .addAll(allProducts.where((pr) => pr.category == category));
    } else {
      filteredProducts.addAll(allProducts.where((ProductModel produto) =>
          produto.name.toLowerCase().contains(search.toLowerCase())));
    }
    return filteredProducts;
  }

  List<ProductModel> filteredProductsByStore(String storeId) {
    final List<ProductModel> filteredProducts = []..length;
    if (search.isEmpty) {
      filteredProducts.addAll(
          allProducts.where((ProductModel product) => product.shop == storeId));
    } else {
      filteredProducts.addAll(allProducts.where((ProductModel produto) =>
          produto.name.toLowerCase().contains(search.toLowerCase())));
    }
    return filteredProducts;
  }

  ProductModel findProductById(String id) {
    try {
      return allProducts.firstWhere((ProductModel p) => p.id == id);
    } catch (error) {
      debugPrint('$error');
      return null;
    }
  }
}
