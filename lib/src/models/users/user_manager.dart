// @dart=2.9
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/common/constants.dart';
import 'package:cuyuyu/src/common/firebase_errors.dart';
import 'package:cuyuyu/src/models/address/address_model.dart';
import 'package:cuyuyu/src/models/users/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _retriviewUsers();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserModel user;
  bool _loading = false;
  bool get loading => _loading;
  bool _googleLoading = false;
  bool get googleLoading => _googleLoading;

  bool get isLoggedIn => user != null;

  bool _obscuredText = true;
  bool get obscuredText => _obscuredText;

  set obscuredText(bool value) {
    _obscuredText = value;
    notifyListeners();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  set googleLoading(bool value) {
    _googleLoading = value;
    notifyListeners();
  }

  bool get adminEnabled => user != null && user.admin;

  Future<void> sigIn(
      {@required UserModel user,
      @required Function onFail,
      @required Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
              email: user.userMail, password: user.password);

      await _retriviewUsers(firestoreUser: userCredential.user);

      onSuccess();
    } on FirebaseAuthException catch (error) {
      onFail(getErrorString(error.code));
    }
    loading = false;
  }

  Future<void> signInWithGoogle({Function onFail, Function onSuccess}) async {
    await Firebase.initializeApp();
    googleLoading = true;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    try {
      final UserCredential authResult =
          await auth.signInWithCredential(credential);
      final User user = authResult.user;
      if (user != null) {
        final User currentUser = auth.currentUser;
        assert(user.uid == currentUser.uid);
        assert(user.email != null);
        assert(user.displayName != null);

        this.user = UserModel(
          userId: user.uid,
          userMail: user.email,
          userPhoneNumber: user.phoneNumber ?? "000000000",
          userName: user.displayName,
          userUrlFoto: user.photoURL,
          userAddress: AddressModel(
            street: 'default',
            district: 'default',
            city: 'default',
            province: 'default',
            country: 'Angola',
            latitude: 1.1,
            longitude: 1.1,
          ),
        );

        if (authResult.additionalUserInfo.isNewUser) {
          await this.user.saveData();
          this.user.saveToken();
        }
      }
      googleLoading = false;
      onSuccess();
    } on FirebaseAuthException catch (error) {
      googleLoading = false;
      onFail(error);
      return Future.error('Um erro inesperado aconteceu! $error');
    }
  }

  Future<void> signUp(
      {@required UserModel userModel,
      @required Function onFail,
      @required Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
              email: userModel.userMail, password: userModel.password);

      userModel.userId = userCredential.user.uid;
      userModel.userUrlFoto = profilePicture;
      userModel.userAddress = AddressModel(
        street: 'default',
        district: 'default',
        city: 'default',
        province: 'default',
        country: 'Angola',
        latitude: 1.1,
        longitude: 1.1,
      );

      user = userModel;

      await user.saveData();

      user.saveToken();

      onSuccess();
    } on FirebaseAuthException catch (error) {
      onFail(getErrorString(error.code));
    }
    loading = false;
  }

  Future<void> updateUser(
      {UserModel user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      this.user = user;
      await user.saveData();
      onSuccess();
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      onFail(error.message);
      loading = false;
    }
    loading = false;
  }

  Future<void> _retriviewUsers({User firestoreUser}) async {
    final User currentUser = firestoreUser ?? auth.currentUser;

    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection("users").doc(currentUser.uid).get();

      user = UserModel.fromDocument(docUser);

      user.saveToken();

      final adminDoc =
          await firestore.collection('admins').doc(user.userId).get();
      if (adminDoc.exists) {
        user.admin = true;
      }

      notifyListeners();
    }
  }

  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      if (!kIsWeb) {
        await googleSignIn.signOut().whenComplete(() {
          debugPrint('Log Out com sucesso! ');
        });
      }
      await auth.signOut();
      user = null;
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      debugPrint('Erro ao fazer logout ${error}');
    }
  }

  Future<void> resetPassword(
      {String email, Function onSuccess, Function onError}) async {
    loading = true;
    await auth.sendPasswordResetEmail(email: email).whenComplete(() {
      onSuccess();
      loading = false;
    }).onError((error, StackTrace stackTrace) {
      loading = false;
      onError(error);
    });
  }

  Future<void> deleteAccount({Function onError}) async {
    try {
      User user = await auth.currentUser;
      await firestore.collection("users").doc(user.uid).delete();
      await user.delete();
      auth.signOut();
      await GoogleSignIn().signOut();
      this.user = null;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      onError(e);
    }
  }
}
