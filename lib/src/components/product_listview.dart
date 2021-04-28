import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/models/cart_model.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/databases/database_app.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:cuyuyu/src/utils/smooth_star_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:toast/toast.dart';

class ProductLisView extends StatefulWidget {
  final VoidCallback callback;
  final DocumentSnapshot productData;
  final String shopName;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  const ProductLisView(
      {Key key,
      this.callback,
      this.productData,
      this.shopName,
      this.animationController,
      this.animation})
      : super(key: key);

  @override
  _ProductLisViewState createState() => _ProductLisViewState();
}

class _ProductLisViewState extends State<ProductLisView> {
  final dbHelper = DatabaseApp.instance;
  List<CartModel> list = List();

  @override
  void initState() {
    _getCarts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: widget.animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50.0 * (1.0 - widget.animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  widget.callback();
                },
                child: Container(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              color: ShopAppTheme.buildLightTheme()
                                  .backgroundColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Card(
                                        elevation: 3,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              height: 125,
                                              width: 110,
                                              padding: EdgeInsets.only(
                                                  left: 0,
                                                  top: 10,
                                                  bottom: 70,
                                                  right: 20),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: widget.productData[
                                                                      'image_url_product'] !=
                                                                  null ||
                                                              widget
                                                                  .productData[
                                                                      'image_url_product']
                                                                  .isNotEmpty
                                                          ? NetworkImage(widget
                                                                  .productData[
                                                              'image_url_product'])
                                                          : AssetImage(
                                                              'images/app_logo.png'),
                                                      fit: BoxFit.cover)),
                                              child: widget.productData[
                                                              'discount_product'] ==
                                                          null ||
                                                      widget.productData[
                                                              'discount_product'] ==
                                                          ""
                                                  ? Container()
                                                  : Container(
                                                      color: Colors.deepOrange,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            '${widget.productData['discount_product']}%',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                          Text(
                                                            "Promoção",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      widget.productData[
                                                          'name_product'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: AppTheme
                                                              .cuyuyuOrange,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 17),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Text(
                                                            '\Kz ${double.parse(widget.productData['old_price_product'])}',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.red
                                                                  .withOpacity(
                                                                      0.8),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Raleway',
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            '\Kz ${double.parse(widget.productData['price_product'])}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1
                                                                .copyWith(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.8),
                                                                  fontFamily:
                                                                      'Raleway',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child:
                                                                SmoothStarRating(
                                                              allowHalfRating:
                                                                  true,
                                                              starCount: 5,
                                                              //rating: hotelData.rating,
                                                              rating: 80,
                                                              size: 20,
                                                              color: ShopAppTheme
                                                                      .buildLightTheme()
                                                                  .primaryColor,
                                                              borderColor: ShopAppTheme
                                                                      .buildLightTheme()
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              'Pedido mínimo ${widget.productData['minimum_number_product']}',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.8)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                              onTap: () {
                                _addToCart(widget.productData);
                                //Update Cart Count
                                _getCarts();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.add_shopping_cart,
                                  color: AppTheme.cuyutyuBlue,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _addToCart(DocumentSnapshot productData) async {
    Map<String, dynamic> row = {
      DatabaseApp.prodId: productData.id,
      DatabaseApp.name: productData['name_product'],
      DatabaseApp.image: productData['image_url_product'],
      DatabaseApp.description: productData['description_product'],
      DatabaseApp.variation: productData['variation_id'],
      DatabaseApp.unity: productData['unity_id'],
      DatabaseApp.price: productData['price_product'],
      DatabaseApp.discount: productData['discount_product'],
      DatabaseApp.iva: productData['iva_product'].toString(),
      DatabaseApp.quantity: "1".toString(),
      DatabaseApp.shop: productData['id_shop'],
      DatabaseApp.nameShopping:widget.shopName,
      DatabaseApp.frete: productData['frete']
    };

    CartModel model = CartModel.fromMap(row);
    final count = await dbHelper.isInCart(model);

    if (count.length > 0) {
      dbHelper.singleUpdate(model);
      Toast.show(model.cartName + " já foi comprado.", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      dbHelper.addToCart(model);
      Toast.show("Adicionado ao carrinho", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void _getCarts() async {
    final allRows = await dbHelper.getCarts();
    list.clear();
    allRows.forEach((row) => list.add(CartModel.fromMap(row)));
  }
}
