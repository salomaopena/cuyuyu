// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/models/address/address_model.dart';
import 'package:cuyuyu/src/models/cart/cart_product.dart';
import 'package:cuyuyu/src/models/products/product.dart';
import 'package:cuyuyu/src/models/users/user_manager.dart';
import 'package:cuyuyu/src/models/users/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocode/geocode.dart';

class CartManager extends ChangeNotifier {
  List<CartProduct> items = []..length;
  UserModel user;
  AddressModel address;

  num productsPrice = 0.0;
  num deliveryPrice = 0.0;

  num get totalPrice => productsPrice + deliveryPrice;

  bool _loading = false;
  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateUser(UserManager userManager) {
    user = userManager.user;
    productsPrice = 0.0;
    items.clear();
    removeAddress();
    if (user != null) {
      _loadCartItems();
      _loadUserAddress();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await user.cartReference.get();
    items = cartSnap.docs
        .map(
            (doc) => CartProduct.fromDocument(doc)..addListener(_onItemUpdated))
        .toList();
  }

  Future<void> _loadUserAddress() async {
    if (user.userAddress != null &&
        await calculateDelivey(
            user.userAddress.latitude, user.userAddress.longitude)) {
      address = user.userAddress;
      notifyListeners();
    }
  }

  void addToCart(ProductModel product) {
    try {
      final e = items.firstWhere((p) => p.stackable(product));
      e.increment();
    } catch (error) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      user.cartReference
          .add(cartProduct.toCartItemMap())
          .then((doc) => cartProduct.id = doc.id)
          .whenComplete(() {
        debugPrint("${cartProduct.product.name} Adicionado ao carrinho!");
      });
      _onItemUpdated();
    }
    notifyListeners();
  }

  void _onItemUpdated() {
    productsPrice = 0.0;
    for (int i = 0; i < items.length; i++) {
      final cartProduct = items[i];
      if (cartProduct.quantity == 0) {
        _removeFromCart(cartProduct);
        i--;
        continue;
      } else {
        productsPrice += cartProduct.totalPrice;
        _updateCartProduct(cartProduct: cartProduct);
      }
    }
    notifyListeners();
  }

  void _removeFromCart(CartProduct cartProduct) {
    items.removeWhere((p) => p.id == cartProduct.id);
    user.cartReference.doc(cartProduct.id).delete().whenComplete(() {
      debugPrint('${cartProduct.product.name} Removido do carrinho');
    });
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

  Future<void> _updateCartProduct({@required CartProduct cartProduct}) async {
    if (cartProduct.id != null) {
      await user.cartReference
          .doc(cartProduct.id)
          .update(cartProduct.toCartItemMap())
          .whenComplete(
              () => debugPrint('${cartProduct.product.name} actualizado'))
          .catchError((error) => debugPrint('Erro ao actualizar $error'));
    }
  }

  bool get isAddressValid => address != null && deliveryPrice > 0.0;

  Future<void> getAddress(
      {@required double latitude, @required double longitude}) async {
    loading = true;
    GeoCode geoCode = GeoCode();
    try {
      final add = await geoCode.reverseGeocoding(
          latitude: latitude, longitude: longitude);

      if (add != null) {
        address = AddressModel(
          street: add.streetAddress,
          district: add.streetAddress,
          city: add.city,
          province: add.region,
          country: add.countryName,
          latitude: latitude,
          longitude: longitude,
        );
      }
      loading = false;
    } catch (error) {
      loading = false;
      debugPrint(error.toString());
      return Future.error('Localização inválida!!');
    }
  }

  Future<void> setAddress(AddressModel address) async {
    loading = true;
    this.address = address;
    if (await calculateDelivey(
        address.latitude, address.longitude)) {
      user.setAddress(address);
      loading = false;
    } else {
      loading = false;
      return Future.error('Endereço fora do raio de entrega :(');
    }
  }

  void removeAddress() {
    address = null;
    deliveryPrice = 0.0;
    notifyListeners();
  }

  Future<Position> determinePosition() async {
    bool isLocationServiceEnabled;
    LocationPermission permission;

    isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Os serviços de localização estão desactivados');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('As permissões de localização são negadas');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'As permissões de localização são permanentemente negadas, não podemos pedir permissões.');
    }

    Position position = await Geolocator.getCurrentPosition();

    if (position != null) {
      await getAddress(
          latitude: position.latitude, longitude: position.longitude);
    }

    return position;
  }

  Future<bool> calculateDelivey(double latitude, double longitude) async {
    final DocumentSnapshot documentSnapshot =
        await firestore.doc('config/delivery').get();
    final latStore = documentSnapshot.get('latitude') as double;
    final longStore = documentSnapshot.get('longitude') as double;
    final maxKm = documentSnapshot.get('distance') as num;
    final basePrice = documentSnapshot.get('baseprice') as num;
    final priceByKm = documentSnapshot.get('km') as num;

    double distance = await Geolocator.distanceBetween(
        latStore, longStore, latitude, longitude);

    distance /= 1000.0;

    if (distance > maxKm) {
      return false;
    }
    deliveryPrice = basePrice + distance * priceByKm;
    return true;
  }

  void clear() {
    for (final cartProduct in items) {
      user.cartReference.doc(cartProduct.id).delete();
    }
    items.clear();
    notifyListeners();
  }
}
