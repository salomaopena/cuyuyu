import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/custom_drawer/navigation_home_screen.dart';
import 'package:cuyuyu/src/models/cart_model.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/databases/database_app.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toast/toast.dart';

String backendUrl = '{YOUR_BACKEND_URL}';
String paystackPublicKey = '{YOUR_PAYSTACK_PUBLIC_KEY}';
const String appName = 'Cuyuyu';

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
  bool handPayment = false;
  bool tpaPayment = false;
  bool senderPayment = false;
  bool thisAddress = true;

  Position _position;
  StreamSubscription<Position> _streamSubscription;
  Address _address;


  final _formKey = GlobalKey<FormState>();
  final _firebaseAuth = FirebaseAuth.instance;
  final orderReference = FirebaseFirestore.instance.collection(ORDERS);
  CollectionReference userReference;
  final dbHelper = DatabaseApp.instance;
  final String orderId = Timestamp.now().nanoseconds.toString();

  String streetOrHome = "";
  String autorite = "";
  String comment = "";
  String paymentMethod = "";
  String addrese = "";

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
            .then((value) => _address = value);
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
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: ShopAppTheme.buildLightTheme().backgroundColor,
      child: SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: <Widget>[
                getAppBarUI(),
                Expanded(
                  child: SingleChildScrollView(
                      child: _firebaseAuth.currentUser != null
                          ? FutureBuilder(
                              future: loadUser(),
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Container(
                                        height: 130,
                                        child: AspectRatio(
                                          aspectRatio: 2,
                                          child: Container(
                                            child: getLayout(),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0,
                                            top: 4.0,
                                            right: 8.0,
                                            bottom: 4.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Text(
                                              "Endereço de entrega",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5
                                                  .copyWith(
                                                      color:
                                                          AppTheme.cuyutyuBlue,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(),
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
                                                  left: 8.0,
                                                  top: 4.0,
                                                  bottom: 4.0,
                                                  right: 8.0),
                                              child: TextFormField(
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .copyWith(
                                                        fontFamily: 'Raleway',
                                                        fontSize: 14),
                                                cursorColor:
                                                    colorScheme.onSurface,
                                                autofocus: true,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  labelText: 'Nº da casa/rua',
                                                  hintText: 'Nº da casa/rua',
                                                ),
                                                initialValue: streetOrHome,
                                                validator: (value) {
                                                  if (thisAddress &&
                                                      (value == null ||
                                                          value
                                                              .trim()
                                                              .isEmpty)) {
                                                    return 'Preenchimento obrigatório!';
                                                  }
                                                  return null;
                                                },
                                                onSaved: (value) {
                                                  streetOrHome = value;
                                                },
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 8.0,
                                                  top: 4.0,
                                                  bottom: 4.0,
                                                  right: 8.0),
                                              child: TextFormField(
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .copyWith(
                                                        fontFamily: 'Raleway',
                                                        fontSize: 14),
                                                cursorColor:
                                                    colorScheme.onSurface,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  labelText: 'Bairro',
                                                  hintText: 'Bairro',
                                                ),
                                                initialValue: autorite,
                                                validator: (value) {
                                                  if (thisAddress &&
                                                      (value == null ||
                                                          value
                                                              .trim()
                                                              .isEmpty)) {
                                                    return 'Preenchimento obrigatório!';
                                                  }
                                                  return null;
                                                },
                                                onSaved: (value) {
                                                  autorite = value;
                                                },
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 8.0,
                                                  top: 4.0,
                                                  bottom: 4.0,
                                                  right: 8.0),
                                              child: TextFormField(
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .copyWith(
                                                        fontFamily: 'Raleway',
                                                        fontSize: 14),
                                                cursorColor:
                                                    colorScheme.onSurface,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
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
                                            Divider(
                                              indent: 8.0,
                                              endIndent: 8.0,
                                              color: AppTheme.cuyuyuOrange,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Checkbox(
                                                  value: thisAddress,
                                                  onChanged: (bool newValue) {
                                                    setState(() {
                                                      thisAddress = newValue;
                                                    });
                                                  },
                                                ),
                                                Text(
                                                    'Adicionar este endereço à entrega')
                                              ],
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0,
                                                    top: 4.0,
                                                    right: 8.0,
                                                    bottom: 4.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: <Widget>[
                                                    Text(
                                                      "Forma de pagamento",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          .copyWith(
                                                              color: AppTheme
                                                                  .nearlyBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    SizedBox(height: 5),
                                                  ],
                                                )),
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  new Checkbox(
                                                      value: handPayment,
                                                      activeColor:
                                                          AppTheme.nearlyBlue,
                                                      onChanged:
                                                          (bool newValue) {
                                                        setState(() {
                                                          handPayment =
                                                              newValue;
                                                          if (newValue) {
                                                            paymentMethod =
                                                                "Dinheiro à mão";
                                                          }
                                                        });
                                                      }),
                                                  Text('Dinheiro à mão'),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  new Checkbox(
                                                      value: tpaPayment,
                                                      activeColor:
                                                          AppTheme.nearlyBlue,
                                                      onChanged:
                                                          (bool newValue) {
                                                        setState(() {
                                                          tpaPayment = newValue;
                                                          if (newValue) {
                                                            paymentMethod =
                                                                "Terminal de Pagamento Automático";
                                                          }
                                                        });
                                                      }),
                                                  Text(
                                                      'Terminal de Pagamento Automático'),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  new Checkbox(
                                                      value: senderPayment,
                                                      activeColor:
                                                          AppTheme.nearlyBlue,
                                                      onChanged:
                                                          (bool newValue) {
                                                        setState(() {
                                                          senderPayment =
                                                              newValue;
                                                          setState(() {
                                                            if (newValue) {
                                                              Toast.show(
                                                                  "Forma de pagamento não disponível.",
                                                                  context,
                                                                  duration: Toast
                                                                      .LENGTH_LONG,
                                                                  gravity: Toast
                                                                      .BOTTOM);
                                                            }
                                                            newValue = false;
                                                            senderPayment =
                                                                false;
                                                          });
                                                        });
                                                      }),
                                                  Text(
                                                      'Transferência bancária'),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(16.0),
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: AppTheme.nearlyBlue,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(16.0),
                                          ),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: AppTheme.nearlyBlue
                                                    .withOpacity(0.5),
                                                offset: const Offset(1.1, 1.1),
                                                blurRadius: 10.0),
                                          ],
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            if (handPayment || tpaPayment) {
                                              String userName = snapshot.data
                                                  .data()['userName'];
                                              String userPhone = snapshot.data
                                                  .data()['phoneNumber'];
                                              String userAddress = snapshot.data
                                                  .data()['address'];

                                              buy(
                                                  streetOrHome,
                                                  autorite,
                                                  comment,
                                                  paymentMethod,
                                                  thisAddress,
                                                  userName,
                                                  userPhone,
                                                  userAddress);
                                            } else {
                                              Toast.show(
                                                  "Seleciona uma forma de pagamento.",
                                                  context,
                                                  duration: Toast.LENGTH_LONG,
                                                  gravity: Toast.BOTTOM);
                                            }
                                          },
                                          child: Center(
                                            child: Text(
                                              'Enviar',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                letterSpacing: 0.0,
                                                color: AppTheme.nearlyWhite,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
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
              ],
            )),
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
    _streamSubscription.cancel();
  }

  Future<Address> convertCoordinateToAddress(Coordinates coordinates) async {
    var address =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return address.first;
  }

  void buy(
      String streetOrHome,
      String autorite,
      String comment,
      String paymentMethod,
      bool thisAddress,
      userName,
      String userPhone,
      String userAddress) {
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();
      sendOrders(userName, userPhone, userAddress);
    }
  }

  void sendOrders(userName, userPhone, userAddress) {
    addrese = streetOrHome + ', ' + autorite;
    orderReference.doc(orderId).set({
      USER_ID: _firebaseAuth.currentUser.uid,
      USER_NAME: userName,
      USER_PHONE: userPhone,
      USER_MAIL: _firebaseAuth.currentUser.email,
      USER_ADDRESS: userAddress,
      FRETE: widget.frete,
      ORDER_ADRESS: addrese,
      LOCATION:GeoPoint(_position.latitude,_position.longitude),
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
        var list = new List<Map<String, dynamic>>();
        list.add(data);
        orderReference
            .doc(orderId)
            .update({ORDER_DETAIL: FieldValue.arrayUnion(list)});
      }
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Informação"),
              content: Text("O seu pedido foi realizado com sucesso!"),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    dbHelper.deleteCart();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NavigationHomeScreen(),
                    ));
                  },
                )
              ],
            );
          });
    }).catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Erro"),
              content: Text(err.message),
              actions: [
                FlatButton(
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

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: ShopAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Adicionar endereço',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    fontFamily: 'Raleway',
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }

  Widget getLayout() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: loadUser(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Card(
                          margin: EdgeInsets.only(left: 4, right: 4),
                          color: Colors.white,
                          elevation: 3,
                          child: SizedBox(
                              height: 100,
                              width: 80,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Icon(
                                        Icons.home,
                                        color: AppTheme.transparentYellow,
                                      ),
                                    ),
                                    Text(
                                      'Endereço de entrega',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: AppTheme.grey,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ))),
                    ),
                    Expanded(
                      flex: 1,
                      child: Card(
                          margin: EdgeInsets.only(left: 4, right: 4),
                          color: AppTheme.transparentYellow,
                          elevation: 3,
                          child: SizedBox(
                              height: 80,
                              width: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Icon(
                                        Icons.account_circle,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                    Text(
                                      '${snapshot.data.data()['userName']},\n${snapshot.data.data()['userMail']}',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ))),
                    ),
                    Expanded(
                      flex: 1,
                      child: Card(
                          margin: EdgeInsets.only(left: 4, right: 4),
                          color: AppTheme.transparentYellow,
                          elevation: 3,
                          child: SizedBox(
                              height: 80,
                              width: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Icon(Icons.work,
                                          color: Colors.white, size: 20),
                                    ),
                                    Text(
                                      'Outros locais',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ))),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<DocumentSnapshot> loadUser() {
    return userReference.doc(_firebaseAuth.currentUser.uid).get();
  }
}
