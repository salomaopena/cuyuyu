import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/components/product_listview.dart';
import 'package:cuyuyu/src/models/cart_model.dart';
import 'package:cuyuyu/src/models/product_category.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/databases/database_app.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'cart_page.dart';

class ProductByCategory extends StatefulWidget {
  final ProductCategory category;

  const ProductByCategory({Key key, this.category}) : super(key: key);

  @override
  _ProductByCategoryState createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory>
    with TickerProviderStateMixin {
  AnimationController animationController;
  bool multiple = true;
  List<CartModel> carts = List();
  final dbHelper = DatabaseApp.instance;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _getCarts();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ShopAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: Stack(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: [
                    getAppBarUI(),
                    Expanded(
                      child: NestedScrollView(
                        controller: _scrollController,
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return Column(
                                  children: <Widget>[
                                    //Caixinha de pesquisa
                                    getSearchBarUI(),
                                  ],
                                );
                              }, childCount: 1),
                            ),
                          ];
                        },
                        body: FutureBuilder(
                          future: loadProductByCategory(widget.category.id),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return Container(
                                  child: Center(
                                      child: new Text(
                                          'Internet fraca. \nPor favar, verifique a sua conexão.')),
                                );
                              case ConnectionState.waiting:
                                return Container(
                                  child: Center(
                                      child: new CircularProgressIndicator()),
                                );
                              default:
                                if (snapshot.hasError) {
                                  return Container(
                                    child: Center(
                                      child:
                                          new Text('Erro : ${snapshot.error}'),
                                    ),
                                  );
                                } else if (!snapshot.hasData) {
                                  return Center(
                                    child: Text('Sem dados'),
                                  );
                                } else {
                                  return snapshot.data.docs.length > 0
                                      ? Container(
                                          color: ShopAppTheme.buildLightTheme()
                                              .backgroundColor,
                                          child: ListView.builder(
                                            padding: EdgeInsets.only(top: 8.0),
                                            itemCount:
                                                snapshot.data.docs.length,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final int count =
                                                  snapshot.data.docs.length > 10
                                                      ? 10
                                                      : snapshot
                                                          .data.docs.length;
                                              final Animation<
                                                  double> animation = Tween<
                                                          double>(
                                                      begin: 0.0, end: 1.0)
                                                  .animate(CurvedAnimation(
                                                      parent:
                                                          animationController,
                                                      curve: Interval(
                                                          (1 / count) * index,
                                                          1.0,
                                                          curve: Curves
                                                              .fastOutSlowIn)));
                                              animationController.forward();
                                              return ProductLisView(
                                                callback: () {
                                                 /* Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductDetailPage(
                                                                item: snapshot
                                                                        .data
                                                                        .docs[
                                                                    index],
                                                              )));*/
                                                },
                                                productData:
                                                    snapshot.data.docs[index],
                                                animation: animation,
                                                animationController:
                                                    animationController,
                                              );
                                            },
                                          ),
                                        )
                                      : Center(
                                          child: CircularProgressIndicator(),
                                        );
                                }
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<QuerySnapshot> loadProductByCategory(String categoryId) {
    if (categoryId.isNotEmpty || categoryId != null) {
      return FirebaseFirestore.instance
          .collection('Product')
          .where('product_category_id', isEqualTo: categoryId)
          .get();
    }
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: ShopAppTheme.buildLightTheme().backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (String txt) {},
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: ShopAppTheme.buildLightTheme().primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Pesquisar...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: ShopAppTheme.buildLightTheme().primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.search,
                      size: 20,
                      color: ShopAppTheme.buildLightTheme().backgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: ShopAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 4, right: 4),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.white,
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
              child: Text(
                '${widget.category.name}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Badge(
                          badgeContent: Text(
                            '${carts.length}',
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: AppTheme.nearlyWhite,
                                      fontFamily: 'Raleway',
                                    ),
                          ),
                          child: Icon(
                            Icons.shopping_cart,
                            color: AppTheme.nearlyBlack,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CartPage()));
                          //CartPage
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _getCarts() async {
    final allRows = await dbHelper.getCarts();
    carts.clear();
    allRows.forEach((row) => carts.add(CartModel.fromMap(row)));
    setState(() {});
  }
}
