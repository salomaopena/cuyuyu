//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/pages/cart_page.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/order_custom_button.dart';
import 'package:cuyuyu/src/utils/progress_dialog.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeAddress extends StatefulWidget {
  const ChangeAddress({Key key}) : super(key: key);

  @override
  _ChangeAddressState createState() => _ChangeAddressState();
}

class _ChangeAddressState extends State<ChangeAddress> {
  final _formKey = GlobalKey<FormState>();
  final user = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference userReference;
  String streetNumber = "";
  String homeNumber = "";
  String address = "";
  ProgressDialog pr;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    userReference = user.collection(USER_URL);
    FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Alterar endereço", style: AppTheme.title),
        elevation: 0,
        iconTheme: IconThemeData.fallback(),
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.nearlyBlack,
      ),
      backgroundColor: AppTheme.nearlyWhite,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              left: getProportionateScreenWidth(16.0),
              right: getProportionateScreenWidth(16.0)),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("Dados do endereço",
                    style: AppTheme.display6, textAlign: TextAlign.center),
                SizedBox(height: getProportionateScreenHeight(40)),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  style: AppTheme.display4.copyWith(fontFamily: 'Muli'),
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Casa nº',
                    hintText: 'Casa nº',
                  ),
                  initialValue: homeNumber,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Preenchimento obrigatório!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    homeNumber = value;
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                TextFormField(
                  style: AppTheme.display4.copyWith(fontFamily: 'Muli'),
                  textCapitalization: TextCapitalization.characters,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Rua nº',
                    hintText: 'Rua nº',
                  ),
                  initialValue: streetNumber,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Preenchimento obrigatório!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    streetNumber = value;
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  style: AppTheme.display4.copyWith(fontFamily: 'Muli'),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    labelText: 'Endereço',
                    hintText: 'Endereço',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  initialValue: address,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Preenchimento obrigatório!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    address = value;
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(25)),
                OrderFlutterButton(
                    title: !isLoading
                        ? Text(
                            "Guardar",
                            style: AppTheme.display5,
                          )
                        : CircularProgressIndicator(),
                    onPressed: () {
                      isLoading = true;
                      bool isValid = _formKey.currentState.validate();
                      if (isValid) {
                        _formKey.currentState.save();
                        if (auth.currentUser != null) {
                          userReference.doc(auth.currentUser.uid).update({
                            "address": "Casa nº " +
                                homeNumber +
                                ", rua nº " +
                                streetNumber +
                                ", " +
                                address,
                          }).then((value) {
                            pr.style(
                                message: 'Aguarde...',
                                borderRadius: 10.0,
                                backgroundColor: Colors.white,
                                progressWidget: CircularProgressIndicator(),
                                elevation: 10.0,
                                insetAnimCurve: Curves.easeInOut,
                                progress: 0.0,
                                maxProgress: 100.0,
                                progressTextStyle: AppTheme.caption,
                                messageTextStyle: AppTheme.display6);
                            pr.show();
                            Future.delayed(Duration(seconds: 5)).then((value) {
                              pr.hide().whenComplete(() {
                                Get.to(()=>CartPage());
                                isLoading = false;
                              });
                            });
                          });
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
