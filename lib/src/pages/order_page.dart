//@dart=2.9
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/models/cart_model.dart';
import 'package:cuyuyu/src/pages/change_address.dart';
import 'package:cuyuyu/src/pages/home/home_screen.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/databases/database_app.dart';
import 'package:cuyuyu/src/utils/order_custom_button.dart';
import 'package:cuyuyu/src/utils/progress_dialog.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:toast/toast.dart';

class OrderPage extends StatefulWidget {
  final List<CartModel> list;
  final double subtotal;
  final double frete;
  final double total;

  const OrderPage({Key key, this.list, this.subtotal, this.frete, this.total})
      : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool isLoading = false;

  Position _position;
  StreamSubscription<Position> _streamSubscription;

  final _formKey = GlobalKey<FormState>();
  final _firebaseAuth = FirebaseAuth.instance;
  final orderReference = FirebaseFirestore.instance.collection(ORDERS);
  CollectionReference userReference;
  final dbHelper = DatabaseApp.instance;
  final String orderId = Timestamp.now().nanoseconds.toString();

  ProgressDialog pr;

  String comment = "";
  String paymentMethod = "";
  String userName = "";
  String userPhone = "";
  String userAddress = "";

  @override
  void initState() {
    _streamSubscription = Geolocator.getPositionStream(
            desiredAccuracy: LocationAccuracy.high, distanceFilter: 10)
        .listen((Position position) {
      setState(() {
        print(position);
        _position = position;
        final coordinates = Coordinates(position.latitude, position.longitude);
        convertCoordinateToAddress(coordinates)
            .then((value) => value);
      });
    });
    userReference = FirebaseFirestore.instance.collection(USER_URL);
    if (_firebaseAuth.currentUser != null) {
      loadUser();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Finalizar a compra", style: AppTheme.title),
        elevation: 0,
        iconTheme: IconThemeData.fallback(),
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.nearlyBlack,
      ),
      backgroundColor: AppTheme.nearlyWhite,
      body: Center(
        child: SingleChildScrollView(
            child: _firebaseAuth.currentUser != null
                ? Container(
                    child: FutureBuilder(
                      future: loadUser(),
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Container(
                              child: Center(
                                  child: new Text(
                                      'Internet fraca. \nPor favar, verifique a sua conexão.')),
                            );
                          default:
                            if (snapshot.hasError) {
                              return Container(
                                child: Center(
                                  child: new Text('Erro : ${snapshot.error}'),
                                ),
                              );
                            } else if (!snapshot.hasData) {
                              return Center(
                                child: Text('Não existe cadastro'),
                              );
                            } else {
                              return Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text("Endereço de entrega",
                                          style: AppTheme.display6),
                                    ),
                                    Card(
                                      margin: EdgeInsets.only(
                                          left:
                                              getProportionateScreenWidth(16.0),
                                          right: getProportionateScreenWidth(
                                              16.0)),
                                      color: AppTheme.cuyuyuSurfaceWhite,
                                      elevation: 0.5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${snapshot.data.data()['address']}.\n\n${snapshot.data.data()['phoneNumber']}',
                                          style: AppTheme.display4
                                              .copyWith(fontFamily: 'Muli'),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: getProportionateScreenHeight(20),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: getProportionateScreenWidth(
                                              160.0),
                                          right: getProportionateScreenWidth(
                                              16.0)),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(()=>ChangeAddress());
                                        },
                                        child: Text(
                                          "Alterar endereço de entrega",
                                          style: AppTheme.display4.copyWith(
                                              color: AppTheme.closeColor),
                                        ),
                                      ),
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                left:
                                                    getProportionateScreenWidth(
                                                        16.0),
                                                top:
                                                    getProportionateScreenHeight(
                                                        20.0),
                                                bottom:
                                                    getProportionateScreenHeight(
                                                        4.0),
                                                right:
                                                    getProportionateScreenWidth(
                                                        16.0)),
                                            child: TextFormField(
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              style: AppTheme.display4
                                                  .copyWith(fontFamily: 'Muli'),
                                              autofocus: false,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                ),
                                                labelText: 'Comentário',
                                                hintText: 'Comentário',
                                              ),
                                              maxLines: 3,
                                              maxLength: 300,
                                              initialValue: comment,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.trim().isEmpty) {
                                                  return 'Preenchimento obrigatório!';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                comment = value;
                                              },
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                      getProportionateScreenWidth(
                                                          16.0),
                                                  top:
                                                      getProportionateScreenHeight(
                                                          8.0),
                                                  bottom:
                                                      getProportionateScreenHeight(
                                                          4.0),
                                                  right:
                                                      getProportionateScreenWidth(
                                                          16.0)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                  Text(
                                                    "Forma de pagamento",
                                                    style: AppTheme.display6
                                                        .copyWith(
                                                            color: AppTheme
                                                                .closeColor),
                                                  ),
                                                  SizedBox(height: 5),
                                                ],
                                              )),
                                          RadioButtonGroup(
                                              labels: <String>[
                                                "Dinheiro à mão",
                                                "Terminal de Pagamento Automático",
                                                "Transferência bancária"
                                              ],
                                              labelStyle: AppTheme.display4
                                                  .copyWith(fontFamily: 'Muli'),
                                              disabled: [
                                                "Transferência bancária"
                                              ],
                                              onSelected: (String selected) {
                                                setState(() {
                                                  if (selected.contains(
                                                      "Transferência bancária")) {
                                                    Toast.show(
                                                        "Forma de pagamento não disponível.",
                                                        context,
                                                        duration:
                                                            Toast.LENGTH_LONG,
                                                        gravity: Toast.BOTTOM);
                                                  } else {
                                                    paymentMethod = selected;
                                                  }
                                                });
                                              }),
                                        ],
                                      ),
                                    ),
                                    OrderFlutterButton(
                                      title: !isLoading
                                          ? Text(
                                              'Comprar',
                                              textAlign: TextAlign.center,
                                              style: AppTheme.display6.copyWith(
                                                  color: AppTheme.nearlyWhite),
                                            )
                                          : Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                      onPressed: () {
                                        if (paymentMethod.isNotEmpty ||
                                            paymentMethod.length > 0) {
                                          userName =
                                              snapshot.data.data()['userName'];
                                          userPhone = snapshot.data
                                              .data()['phoneNumber'];
                                          userAddress =
                                              snapshot.data.data()['address'];
                                          buy();
                                        } else {
                                          setState(() {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Seleciona a forma de pagamento"),
                                              backgroundColor:
                                                  AppTheme.closeColor,
                                              padding: EdgeInsets.only(
                                                  left:
                                                      getProportionateScreenWidth(
                                                          16.0),
                                                  right:
                                                      getProportionateScreenWidth(
                                                          16.0)),
                                            ));
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }
                        }
                      },
                    ),
                  )
                : Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 50),
                          child: Center(
                            child: Text(
                              'Por favor, inicie sessão para continuar com a operação',
                              textAlign: TextAlign.center,
                              style: AppTheme.title.copyWith(
                                color: AppTheme.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  Future<Address> convertCoordinateToAddress(Coordinates coordinates) async {
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return address.first;
  }

  void buy() {
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();
      sendOrders();
      setState(() {
        isLoading = true;
      });
    }
  }

  void sendOrders() {
    if (_position != null) {
      orderReference.doc(orderId).set({
        USER_ID: _firebaseAuth.currentUser.uid,
        USER_NAME: userName,
        ORDER_ID: orderId,
        USER_PHONE: userPhone,
        USER_MAIL: _firebaseAuth.currentUser.email,
        USER_ADDRESS: userAddress,
        FRETE: widget.frete,
        LOCATION: GeoPoint(_position.latitude, _position.longitude),
        ORDER_DATE: Timestamp.now(),
        PAYMENT: paymentMethod,
        STATUS: "Em processamento",
        COMMENT: comment,
        SUBTOTAL: widget.subtotal,
        TOTAL: widget.total
      }).then((value) {
        for (var i = 0; i < widget.list.length; i++) {
          CartModel cart = widget.list[i];
          Map<String, dynamic> data = new Map();
          data[DatabaseApp.id] = cart.cartId;
          data[DatabaseApp.prodId] = cart.cartProdId;
          data[DatabaseApp.name] = cart.cartName;
          data[DatabaseApp.image] = cart.image;
          data[DatabaseApp.description] = cart.cartDescription;
          data[DatabaseApp.variation] = cart.cartVariation;
          data[DatabaseApp.unity] = cart.cartUnity;
          data[DatabaseApp.price] = cart.cartPrice;
          data[DatabaseApp.discount] = cart.cartDiscount;
          data[DatabaseApp.iva] = cart.cartIva;
          data[DatabaseApp.quantity] = cart.cartQuantity;
          data[DatabaseApp.shop] = cart.shop;
          data[DatabaseApp.nameShopping] = cart.nameShopping;
          data[DatabaseApp.frete] = cart.frete;
          var list = []..length; //List<Map<String, dynamic>> ();
          list.add(data);
          orderReference
              .doc(orderId)
              .update({ORDER_DETAIL: FieldValue.arrayUnion(list)});
        }
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
            dbHelper.deleteCart();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (Route<dynamic> route) => false);
          });
        });
      }).catchError((err) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Erro"),
                content: Text(err.message),
                actions: [
                  TextButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      });
    } else {
      orderReference.doc(orderId).set({
        USER_ID: _firebaseAuth.currentUser.uid,
        USER_NAME: userName,
        ORDER_ID: orderId,
        USER_PHONE: userPhone,
        USER_MAIL: _firebaseAuth.currentUser.email,
        USER_ADDRESS: userAddress,
        FRETE: widget.frete,
        LOCATION: GeoPoint(-14.9213891, 13.4858733),
        ORDER_DATE: Timestamp.now(),
        PAYMENT: paymentMethod,
        STATUS: "Em processamento",
        COMMENT: comment,
        SUBTOTAL: widget.subtotal,
        TOTAL: widget.total
      }).then((value) {
        for (var i = 0; i < widget.list.length; i++) {
          CartModel cart = widget.list[i];
          Map<String, dynamic> data = new Map();
          data[DatabaseApp.id] = cart.cartId;
          data[DatabaseApp.prodId] = cart.cartProdId;
          data[DatabaseApp.name] = cart.cartName;
          data[DatabaseApp.image] = cart.image;
          data[DatabaseApp.description] = cart.cartDescription;
          data[DatabaseApp.variation] = cart.cartVariation;
          data[DatabaseApp.unity] = cart.cartUnity;
          data[DatabaseApp.price] = cart.cartPrice;
          data[DatabaseApp.discount] = cart.cartDiscount;
          data[DatabaseApp.iva] = cart.cartIva;
          data[DatabaseApp.quantity] = cart.cartQuantity;
          data[DatabaseApp.shop] = cart.shop;
          data[DatabaseApp.nameShopping] = cart.nameShopping;
          data[DatabaseApp.frete] = cart.frete;
          var list = []..length;
          list.add(data);
          orderReference
              .doc(orderId)
              .update({ORDER_DETAIL: FieldValue.arrayUnion(list)});
        }
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
            dbHelper.deleteCart();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (Route<dynamic> route) => false);
          });
        });
      }).catchError((err) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Erro"),
                content: Text(err.message),
                actions: [
                  TextButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      });
    }
  }

  Future<DocumentSnapshot> loadUser() async {
    return userReference.doc(_firebaseAuth.currentUser.uid).get();
  }
}
