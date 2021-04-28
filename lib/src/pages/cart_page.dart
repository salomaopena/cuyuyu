import 'dart:math';

import 'package:cuyuyu/src/models/cart_model.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/databases/database_app.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'order_page.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final dbHelper = DatabaseApp.instance;
  final List<CartModel> list = List();

  @override
  void initState() {
    //Toast.show(getDistanceFromGPSPointsInRoute(LatLng(),).toString(), context)
    setState(() {
      _getCarts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ShopAppTheme.buildLightTheme().backgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            getAppBarUI(),
            Expanded(
              child: Center(
                child: getCartList(),
              ),
            ),
            list.length > 0 ? const Divider(height: 1) : Container(),
            list.length > 0
                ? Padding(
                    padding: const EdgeInsets.only(
                        left: 0, right: 0, bottom: 16, top: 16),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              highlightColor: Colors.transparent,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16.0, top: 2, bottom: 2),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Text(
                                              'Subtotal',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: AppTheme.cuyuyuOrange,
                                                  fontFamily: 'Raleway'),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              'Frete',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: AppTheme.cuyuyuOrange,
                                                  fontFamily: 'Raleway'),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              'Total',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: AppTheme.cuyuyuOrange,
                                                  fontFamily: 'Raleway'),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16.0, top: 2, bottom: 2),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Text('Kz. $subtotal',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    color:
                                                        AppTheme.darkerText)),
                                            Text(
                                                'Kz. ${totalFrete.roundToDouble()}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    color:
                                                        AppTheme.darkerText)),
                                            Text(
                                                'Kz. ${totalToPay.roundToDouble()}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    color:
                                                        AppTheme.darkerText)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          margin: EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 8.0, bottom: 0.0),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: const Offset(0, 0),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                if (FirebaseAuth.instance.currentUser != null) {
                                  if (list.length > 0) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => OrderPage(
                                          list: list,
                                          subtotal: subtotal,
                                          frete: totalFrete,
                                          total: totalToPay),
                                    ));
                                  }
                                } else {
                                  Toast.show(
                                      "Por favor, inicie sessão.", context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.CENTER);
                                }
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Center(
                                    child: Text(
                                      'Finalizar',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: AppTheme.nearlyWhite),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Center(
                          child: Image.asset(
                            "images/empty_shopping_cart.png",
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Text(
                          "Não realizou nenhum pedido!",
                          style: AppTheme.textTheme.subtitle2,
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void _getCarts() async {
    final allRows = await dbHelper.getCarts();
    list.clear();
    allRows.forEach((row) => list.add(CartModel.fromMap(row)));
    setState(() {});
  }

  void _delete(CartModel item) async {
    await dbHelper.removeFromCart(item);
  }

  void _descrease(CartModel item) async {
    if (int.parse(item.cartQuantity) > 1) {
      await dbHelper.decreaseCart(item);
    }
  }

  void _increase(CartModel item) async {
    await dbHelper.inecreaseCart(item);
  }

  double get subtotal {
    double subtotal = 0.0;
    for (var i = 0; i < list.length; i++) {
      subtotal = subtotal +
          double.parse(list[i].cartPrice) * int.parse(list[i].cartQuantity);
    }
    return subtotal;
  }

  double get totalFrete {
    double subtotal = 0.0;
    for (var i = 0; i < list.length; i++) {
      subtotal = subtotal + double.parse(list[i].frete) * 1;
    }
    return subtotal;
  }

  double get totalToPay {
    double total = 0.0;
    total = subtotal + totalFrete;
    return total;
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double get distance {
    double totalDistance =
        calculateDistance(-14.9106226, 13.4582876, -14.9218986, 13.5704215);
    return totalDistance.roundToDouble();
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
                  'Carrinho de compras',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
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

  Widget getCartList() {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.only(left: 6.0, right: 6.0, top: 8.0, bottom: 8.0),
        itemCount: list.length,
        itemBuilder: (context, index) {
          CartModel item = list[index];
          return list.length > 0
              ? Card(
                  elevation: 3,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 125,
                        width: 110,
                        padding: EdgeInsets.only(
                            left: 0, top: 10, bottom: 70, right: 20),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    item.image != null || item.image.isNotEmpty
                                        ? NetworkImage(item.image)
                                        : AssetImage('images/app_logo.png'),
                                fit: BoxFit.cover)),
                        child: item.cartDiscount == null
                            ? Container()
                            : Container(
                                color: Colors.deepOrange,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      '${item.cartDiscount}%',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      "Promoção",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${item.cartName}',
                                style: TextStyle(
                                    color: AppTheme.cuyuyuOrange,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '${item.cartDescription}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black87),
                              ),
                              Text(
                                '\Kz ${double.parse(item.cartPrice)}',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Subtotal:",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '\Kz ${(double.parse(item.cartPrice) * int.parse(item.cartQuantity))}',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: IconButton(
                                            icon: Icon(Icons.add_circle),
                                            color: AppTheme.nearlyBlue,
                                            onPressed: () {
                                              _increase(item);
                                              _getCarts();
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${item.cartQuantity}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.remove_circle,
                                            ),
                                            color: AppTheme.nearlyBlue,
                                            onPressed: () {
                                              setState(() {
                                                _descrease(item);
                                                _getCarts();
                                              });
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      color: Colors.red,
                                      icon: Icon(Icons.remove_shopping_cart),
                                      onPressed: () {
                                        setState(() {
                                          _delete(item);
                                          _getCarts();
                                          Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                            duration: Duration(seconds: 2),
                                            content: new Text(
                                                'Removido do carrinho'),
                                          ));
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CupertinoActivityIndicator(),
                );
        },
      ),
    );
  }
}
