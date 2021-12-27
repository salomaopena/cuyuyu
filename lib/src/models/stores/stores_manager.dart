//@dart=2.9
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/models/stores/store.dart';
import 'package:flutter/foundation.dart';

class StoresManager extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Stores> stores = [];
  Timer _timer;
  String _search = '';
  String get search => _search;

  StoresManager() {
    _loadStoresList();
    _startTimer();
  }

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  Future<void> _loadStoresList() async {
    final snapshot = await firestore.collection('Shop').get();
    stores = snapshot.docs.map((e) => Stores.fromDocument(e)).toList();
    notifyListeners();
  }


  List<Stores> get filteredStored {
    final List<Stores> filteredStores = []..length;
    if (search.isEmpty) {
      filteredStores.addAll(stores);
    } else {
      filteredStores.addAll(stores.where(
          (store) => store.name.toLowerCase().contains(search.toLowerCase())));
    }
    return filteredStores;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkOpening();
    });
  }

  void _checkOpening() {
    for (final store in stores) {
      store.updateStatus();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
