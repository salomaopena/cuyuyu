//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/models/cart_model.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/databases/database_app.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:cuyuyu/src/utils/smooth_star_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:toast/toast.dart';

class ProductLisView extends StatefulWidget {
  final VoidCallback callback;
  final DocumentSnapshot productData;
  final String shopName;

  const ProductLisView(
      {Key key, this.callback, this.productData, this.shopName})
      : super(key: key);

  @override
  _ProductLisViewState createState() => _ProductLisViewState();
}

class _ProductLisViewState extends State<ProductLisView> {
  final dbHelper = DatabaseApp.instance;
  List<CartModel> list = []..length;

  @override
  void initState() {
    _getCarts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: getProportionateScreenWidth(8.0),
          right: getProportionateScreenWidth(8.0),
          top: getProportionateScreenHeight(4.0),
          bottom: getProportionateScreenHeight(4.0)),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          widget.callback();
        },
        child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      color: AppTheme.nearlyWhite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Card(
                                elevation: 0.5,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: getProportionateScreenHeight(125),
                                      width: getProportionateScreenWidth(110),
                                      padding: EdgeInsets.only(
                                          left: getProportionateScreenWidth(0),
                                          top: getProportionateScreenHeight(10),
                                          bottom:
                                              getProportionateScreenHeight(70),
                                          right:
                                              getProportionateScreenWidth(20)),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: widget.productData[
                                                              'image_url_product'] !=
                                                          null ||
                                                      widget
                                                          .productData[
                                                              'image_url_product']
                                                          .isNotEmpty
                                                  ? NetworkImage(
                                                      widget.productData[
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
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Text(
                                                    '${widget.productData['discount_product']}%',
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              widget
                                                  .productData['name_product'],
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTheme.display4.copyWith(
                                                  color: AppTheme.cuyuyuOrange,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "Muli"),
                                            ),
                                            SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        5)),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    '\Kz ${double.parse(widget.productData['old_price_product'])}',
                                                    style: AppTheme.caption
                                                        .copyWith(
                                                      color: Colors.red
                                                          .withOpacity(0.8),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'Muli',
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      getProportionateScreenWidth(
                                                          4),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '\Kz ${double.parse(widget.productData['price_product'])}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppTheme.caption
                                                        .copyWith(
                                                      color: Colors.black
                                                          .withOpacity(0.8),
                                                      fontFamily: 'Muli',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        5)),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top:
                                                      getProportionateScreenHeight(
                                                          4)),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 3,
                                                    child: SmoothStarRating(
                                                      allowHalfRating: true,
                                                      starCount: 5,
                                                      //rating: hotelData.rating,
                                                      rating: 80,
                                                      size: 20,
                                                      color:
                                                          AppTheme.nearlyGreen,
                                                      borderColor:
                                                          AppTheme.nearlyGreen,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
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
                                                          padding: EdgeInsets.all(8.0),
                                                          child: Icon(
                                                            Icons.add_shopping_cart,
                                                            color: AppTheme.cuyutyuBlue,
                                                          ),
                                                        ),
                                                      ),
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
              ],
            ),
          ),
        ),
      ),
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
      DatabaseApp.nameShopping: widget.shopName,
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
