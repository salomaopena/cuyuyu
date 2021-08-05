//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  static const USER_NAME = "userName";
  static const USER_CARD = "cardId";
  static const PHONE_NUMBER = "phoneNumber";
  static const USER_MAIL = "userMail";
  static const GENDER = "gender";
  static const ADDRESS = "address";
  static const PHOTO_URL = "photoUrl";
  static const TIMESTAMP = "created";

  String userId;
  String userName;
  String userCardId;
  String userPhoneNumber;
  String userMail;
  String userGender;
  String userAddress;
  String userUrlFoto;
  bool isOnline;
  String created;

  UserModel(
      {@required this.userId,
      @required this.userName,
      this.userCardId,
      this.userPhoneNumber,
      @required this.userMail,
      this.userGender,
      @required this.userAddress,
      this.userUrlFoto,
      this.isOnline,
      this.created});

  factory UserModel.fromDocument(DocumentSnapshot snapshot) {
    return UserModel(
        userId: snapshot.id,
        userName: snapshot.data()[USER_NAME],
        userCardId: snapshot.data()[USER_CARD],
        userPhoneNumber: snapshot.data()[PHONE_NUMBER],
        userMail: snapshot.data()[USER_MAIL],
        userGender: snapshot.data()[GENDER],
        userAddress: snapshot.data()[ADDRESS],
        userUrlFoto: snapshot.data()[PHOTO_URL],
        created: snapshot.data()[TIMESTAMP]);
  }
}
