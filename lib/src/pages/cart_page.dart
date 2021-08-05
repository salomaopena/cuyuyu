//@dart=2.9
import 'dart:math';
import 'package:cuyuyu/src/components/bottom_nav_bar.dart';
import 'package:cuyuyu/src/models/cart_model.dart';
import 'package:cuyuyu/src/users/login_page.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/custom_button.dart';
import 'package:cuyuyu/src/utils/databases/database_app.dart';
import 'package:cuyuyu/src/utils/enums.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'order_page.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final dbHelper = DatabaseApp.instance;
  final List<CartModel> list = []..length;

  @override
  void initState() {
    setState(() {
      _getCarts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrinho de compras", style: AppTheme.title),
        elevation: 0,
        iconTheme: IconThemeData.fallback(),
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.nearlyBlack,
      ),
      backgroundColor: AppTheme.nearlyWhite,
      body: Column(
        children: <Widget>[
          Expanded(
            child: getCartList(),
          ),
          list.length > 0
              ? Divider(height: getProportionateScreenHeight(1))
              : Container(),
          list.length > 0
              ? Container(
                  decoration: BoxDecoration(
                    color: AppTheme.cuyuyuSurfaceWhite,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: getProportionateScreenHeight(16),
                        top: getProportionateScreenHeight(16)),
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
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: getProportionateScreenWidth(16.0),
                                        top: getProportionateScreenHeight(2),
                                        bottom: getProportionateScreenHeight(2),
                                        right:
                                            getProportionateScreenWidth(16.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Subtotal',
                                            style: AppTheme.caption.copyWith(
                                                fontFamily: 'Muli',
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            'Frete',
                                            style: AppTheme.caption.copyWith(
                                                fontFamily: 'Muli',
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            'Total',
                                            style: AppTheme.caption.copyWith(
                                                fontFamily: 'Muli',
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              getProportionateScreenWidth(16.0),
                                          top: getProportionateScreenHeight(2),
                                          right:
                                              getProportionateScreenWidth(16.0),
                                          bottom:
                                              getProportionateScreenHeight(2)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text('Kz. $subtotal',
                                              style: AppTheme.caption.copyWith(
                                                  fontFamily: 'Muli',
                                                  fontWeight: FontWeight.w700)),
                                          Text(
                                              'A calcular...', //'Kz. ${totalFrete.roundToDouble()}'
                                              style: AppTheme.caption.copyWith(
                                                  fontFamily: 'Muli',
                                                  fontWeight: FontWeight.w700,
                                                color: AppTheme.closeColor
                                              )),
                                          Text(
                                              'Kz. ${totalToPay.roundToDouble()}',
                                              style: AppTheme.caption.copyWith(
                                                  fontFamily: 'Muli',
                                                  fontWeight: FontWeight.w700)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        OpenFlutterButton(
                            title: 'Finalizar',
                            width: getProportionateScreenWidth(250),
                            height: getProportionateScreenHeight(50),
                            onPressed: () {
                              if (FirebaseAuth.instance.currentUser != null) {
                                if (list.length > 0) {
                                  Get.to(
                                    () => OrderPage(
                                      list: list,
                                      subtotal: subtotal,
                                      frete: totalFrete,
                                      total: totalToPay,
                                    ),
                                  );
                                }
                              } else {
                                Get.to(() => LoginPage());
                              }
                            }),
                      ],
                    ),
                  ),
                )
              : Container(
                  width: double.infinity,
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
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
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
    total = subtotal; //+ totalFrete;
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

  Widget getCartList() {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.only(
          left: getProportionateScreenWidth(6.0),
          right: getProportionateScreenWidth(6.0),
          top: getProportionateScreenHeight(8.0),
          bottom: getProportionateScreenHeight(8.0),
        ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          CartModel item = list[index];
          return list.length > 0
              ? Card(
                  color: AppTheme.cuyuyuSurfaceWhite,
                  elevation: 0.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: getProportionateScreenHeight(125),
                        width: getProportionateScreenWidth(110),
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
                                      style: AppTheme.body2,
                                    ),
                                    Text(
                                      "Promoção",
                                      style: AppTheme.body2,
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
                                style: AppTheme.display4.copyWith(
                                    color: AppTheme.redColor,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Muli'),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              Text(
                                '\Kz ${double.parse(item.cartPrice)}',
                                style: AppTheme.body1.copyWith(
                                    fontFamily: 'Muli',
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Subtotal:",
                                    style: AppTheme.body1.copyWith(
                                      fontFamily: 'Muli',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    width: getProportionateScreenWidth(10),
                                  ),
                                  Text(
                                    '\Kz ${(double.parse(item.cartPrice) * int.parse(item.cartQuantity))}',
                                    style: AppTheme.body1.copyWith(
                                        fontFamily: 'Muli',
                                        fontWeight: FontWeight.w700),
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
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${item.cartQuantity}",
                                            textAlign: TextAlign.center,
                                            style: AppTheme.display4
                                                .copyWith(fontFamily: 'Muli'),
                                          ),
                                        ),
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
                                          ScaffoldMessenger.of(context)
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
