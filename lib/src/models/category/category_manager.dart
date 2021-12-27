//@dart=2.9
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/models/category/product_category.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

class CategoryManager extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  Reference get storageRef => storage.ref().child('productCategory');
  List<ProductCategory> categories = []..length;
  ProductCategory category;

  bool _loading = false;
  bool get loading => _loading;

  CategoryManager() {
    _loadAllCategories();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadAllCategories() async {
    final QuerySnapshot querySnapshotProducts = await firestore
        .collection("Category") /*.orderBy('name_product_category')*/ .get();
    categories = querySnapshotProducts.docs
        .map((doc) => ProductCategory.fromDocument(doc))
        .toList();
    notifyListeners();
  }

  Future<void> deleteCategory({ProductCategory category}) async {
    try {
      storageRef.storage.refFromURL(category.imageUrl).delete();
      await firestore
          .collection('Category')
          .doc(category.id)
          .delete()
          .whenComplete(() {
        notifyListeners();
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
    } catch (error) {
      debugPrint('Erro ao excluir imagem ${category.imageUrl}: ${error}');
    }
  }

  Future<void> addCategory({
    File file,
    ProductCategory category,
    Function onSuccess,
    Function onError,
  }) async {
    loading = true;

    if (file == null) return;
    final String fileName = basename(file.path);

    final UploadTask task = storageRef.child(fileName).putFile(file);
    if (task == null) return;
    final TaskSnapshot snapshot = await task.whenComplete(() {});
    final String urlDownload = await snapshot.ref.getDownloadURL();

    this.category = category;
    category.imageUrl = urlDownload;

    await firestore.collection('Category').add(category.toMap()).then((doc) {
      category.id = doc.id;
      print(category.id);
    }).whenComplete(() {
      onSuccess();
      loading = false;
      notifyListeners();
    }).onError((error, stackTrace) {
      loading = false;
      onError(onError);
    });
  }

  Future<void> saveCategory({
    ProductCategory category,
    Function onSuccess,
    Function onError,
  }) async {
    loading = true;
    this.category = category;

    await firestore
        .collection('Category')
        .doc(category.id)
        .update(category.toMap())
        .whenComplete(() {
      onSuccess();
      loading = false;
      notifyListeners();
    }).onError((error, stackTrace) {
      loading = false;
      onError(onError);
    });
  }
}
