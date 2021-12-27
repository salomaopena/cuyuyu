//@dart=2.9
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/models/address/address_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserModel {
  String userId;
  String userName;
  String userPhoneNumber;
  String userMail;
  AddressModel userAddress;
  String userUrlFoto;
  String password;
  String password2;
  bool admin = false;

  UserModel(
      {this.userId,
      this.userName,
      this.userPhoneNumber,
      this.userMail,
      this.userAddress,
      this.password,
      this.userUrlFoto});

  UserModel.fromDocument(DocumentSnapshot doc) {
    userId = doc.id;
    userName = doc.get('userName') as String;
    userMail = doc.get('userMail') as String;
    userPhoneNumber = doc.get('phoneNumber') as String;
    userUrlFoto = doc.get('photoUrl') as String;
    final bool address = doc.data().toString().contains('userAddress');
    if (address) {
      userAddress =
          AddressModel.fromMap(doc.get('userAddress') as Map<String, dynamic>);
    }
  }

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc("users/$userId");

  CollectionReference get cartReference => firestoreRef.collection("cart");

  CollectionReference get tokenReference => firestoreRef.collection("tokens");

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'userMail': userMail,
      'phoneNumber': userPhoneNumber,
      'photoUrl': userUrlFoto,
      'userAddress': userAddress.toMap(),
    };
  }

  void setAddress(AddressModel address) {
    this.userAddress = address;
    saveData();
  }

  Future<void> saveToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    tokenReference.doc(token).set({
      'token': token,
      'updatedAt': FieldValue.serverTimestamp(),
      'platform': Platform.operatingSystem
    });
  }
}
