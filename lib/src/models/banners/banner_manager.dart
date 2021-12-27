//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/models/banners/banner.dart';
import 'package:flutter/foundation.dart';

class BannerManager extends ChangeNotifier{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<BannerModel> allItems = []..length;

  BannerManager(){
    _loadAllItems();
  }

  Future<void> _loadAllItems() async {
     await firestore.collection('banners').snapshots().listen((snapshot) {
      allItems.clear();
      for (final DocumentSnapshot document in snapshot.docs) {
        allItems.add(BannerModel.fromDocument(document));
      }
      notifyListeners();
    });
  }
}