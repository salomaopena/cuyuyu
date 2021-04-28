import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/models/cart_model.dart';
import 'package:cuyuyu/src/models/wish_list.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/colors.dart';
import 'package:cuyuyu/src/utils/databases/database_app.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ProductDetailPage extends StatefulWidget {
  final DocumentSnapshot item;
  final String shopName;

  const ProductDetailPage({Key key, this.item,this.shopName}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool _isFavorited = false;
  int _counter = 1;
  List<CartModel> carts = List();
  final List<WishListModel> list = List();
  final dbHelper = DatabaseApp.instance;

  int get _defaultValue => _counter;

  void incrementCount() {
    setState(() {
      if (_counter >= 1) {
        _counter++;
      }
    });
  }

  void decrementCount() {
    setState(() {
      if (_counter >= 1 && _counter != 1) {
        _counter--;
      }
    });
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
      } else {
        _isFavorited = true;
      }
    });
  }

  @override
  void initState() {
    isFavorite(widget.item);
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      height: 200,
                      child: AspectRatio(
                        aspectRatio: 1.5,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    widget.item['image_url_product'],
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 4.0, right: 8.0, bottom: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            widget.item['name_product'],
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    color: AppTheme.cuyutyuBlue,
                                    fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(widget.item['unity_id'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                          color: AppTheme.cuyutyuBlue,
                                          fontWeight: FontWeight.bold)),
                              Text('|',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                          color: AppTheme.cuyutyuBlue,
                                          fontWeight: FontWeight.bold)),
                              Text(widget.item['variation_id'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                          color: AppTheme.cuyutyuBlue,
                                          fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '\Kz ${double.parse(widget.item['old_price_product'])}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          fontFamily: 'Raleway',
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Color(0xFFF00000),
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '\Kz ${double.parse(widget.item['price_product'])}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  child: IconButton(
                                    onPressed: () {
                                      _addToCart(widget.item);
                                      _getCarts();
                                    },
                                    icon: Icon(
                                      Icons.add_shopping_cart,
                                      color: cuyuyuDarkYellow,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(
                                'Quantidade mínima para o pedido ${widget.item['minimum_number_product']}'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 0.0, right: 16.0, bottom: 0.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                  icon: Icon(Icons.remove_circle_outline),
                                  color: cuyuyuOrange,
                                  onPressed: () => decrementCount())),
                          Expanded(
                            flex: 1,
                            child: Text('$_defaultValue',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText2),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              color: cuyuyuOrange,
                              onPressed: () => incrementCount(),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: IconButton(
                              icon: !_isFavorited
                                  ? Icon(Icons.favorite_border,
                                      color: cuyutyuBlue)
                                  : Icon(Icons.favorite, color: cuyutyuBlue),
                              onPressed: () {
                                setState(() {
                                  _toggleFavorite();
                                  addToFavorite(widget.item);
                                  _favoriteList();
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 0.0, bottom: 8.0),
                      child: Text(
                        widget.item['description_product'],
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontStyle: FontStyle.normal),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    /*Container(
                      margin: EdgeInsets.all(16.0),
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.nearlyBlue,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: AppTheme.nearlyBlue.withOpacity(0.5),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          share(context, widget.item);
                          Toast.show("Adicionado ao carrinho", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM);
                        },
                        child: Center(
                          child: Text(
                            'Compartilhar',
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
                    ),*/
                  ],
                ),
              ),
            )
          ],
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
      DatabaseApp.quantity: _defaultValue.toString(),
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
    allRows.forEach((row) => carts.add(CartModel.fromMap(row)));
  }

  void _favoriteList() async {
    final allRows = await dbHelper.getFavorites();
    list.clear();
    allRows.forEach((row) => list.add(WishListModel.fromMap(row)));
  }

  void deleteFavorite(WishListModel item) async {
    await dbHelper.removeFromFavorite(item);
  }

  void addToFavorite(DocumentSnapshot item) async {
    Map<String, dynamic> row = {
      DatabaseApp.productId: item.id,
      DatabaseApp.productName: item['name_product'],
      DatabaseApp.imageUrl: item['image_url_product'],
      DatabaseApp.productDescr: item['description_product'],
      DatabaseApp.productVaria: item['variation_id'],
      DatabaseApp.category: item['product_category_id'],
      DatabaseApp.productUnit: item['unity_id'],
      DatabaseApp.productOldPrice: item['old_price_product'],
      DatabaseApp.productPrice: item['price_product'],
      DatabaseApp.productDiscount: item['discount_product'],
      DatabaseApp.productIva: item['iva_product'],
      DatabaseApp.disponibility: item['is_disponible'],
      DatabaseApp.prductFeatured: item['featured_product'],
      DatabaseApp.productMinimum: item['minimum_number_product'],
      DatabaseApp.productStarCount: item['start_count_product'],
      DatabaseApp.productShop: item['id_shop'],
      DatabaseApp.productFrete: item['frete']
    };

    WishListModel model = WishListModel.fromMap(row);
    final count = await dbHelper.isFavorite(model);

    if (count.length > 0) {
      deleteFavorite(model);
      Toast.show("Removido dos favoritos", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          textColor: AppTheme.white);
    } else {
      dbHelper.addToFavorite(model);
      Toast.show("Adicionado aos favoritos", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    }
  }

  Future<bool> isFavorite(DocumentSnapshot item) async {
    Map<String, dynamic> row = {
      DatabaseApp.productId: item.id,
      DatabaseApp.productName: item['name_product'],
      DatabaseApp.imageUrl: item['image_url_product'],
      DatabaseApp.productDescr: item['description_product'],
      DatabaseApp.productVaria: item['variation_id'],
      DatabaseApp.category: item['product_category_id'],
      DatabaseApp.productUnit: item['unity_id'],
      DatabaseApp.productOldPrice: item['old_price_product'],
      DatabaseApp.productPrice: item['price_product'],
      DatabaseApp.productDiscount: item['discount_product'],
      DatabaseApp.productIva: item['iva_product'],
      DatabaseApp.disponibility: item['is_disponible'],
      DatabaseApp.prductFeatured: item['featured_product'],
      DatabaseApp.productMinimum: item['minimum_number_product'],
      DatabaseApp.productStarCount: item['start_count_product'],
      DatabaseApp.productShop: item['id_shop'],
      DatabaseApp.productFrete: item['frete']
    };

    WishListModel model = WishListModel.fromMap(row);
    final count = await dbHelper.isFavorite(model);

    if (count.length > 0) {
      setState(() {
        _isFavorited = true;
      });
    }
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: ShopAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.0),
              offset: const Offset(0, 2),
              blurRadius: 2.0),
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
                  widget.item['name_product'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway',
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
