//@dart=2.9
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/components/bottom_nav_bar.dart';
import 'package:cuyuyu/src/components/horizontal_listview_category.dart';
import 'package:cuyuyu/src/components/product_listview.dart';
import 'package:cuyuyu/src/models/cart_model.dart';
import 'package:cuyuyu/src/pages/product_detail_page.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/config.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/databases/database_app.dart';
import 'package:cuyuyu/src/utils/enums.dart';
import 'package:cuyuyu/src/utils/icon_badge.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'cart_page.dart';
import 'filtere_screen.dart';

class ProdutHomePage extends StatefulWidget {
  @override
  _ProdutHomePageState createState() => _ProdutHomePageState();

  final DocumentSnapshot shopModel;
  const ProdutHomePage({Key key, this.shopModel}) : super(key: key);
}

class _ProdutHomePageState extends State<ProdutHomePage>
    with TickerProviderStateMixin {
  List<CartModel> list = []..length;
  final dbHelper = DatabaseApp.instance;
  String produt = "";

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
        iconTheme: IconThemeData.fallback(),
        centerTitle: true,
        title: Text(
          "${widget.shopModel['name_shopping']}",
          style: AppTheme.title,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.nearlyBlack,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconBadge(
              icon: Icon(
                Icons.shopping_cart_rounded,
                color: AppTheme.nearlyBlack,
              ),
              itemCount: list.length,
              badgeColor: Colors.red,
              itemColor: Colors.white,
              hideZero: true,
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => CartPage()));
                setState(() {
                  _getCarts();
                });
              },
            ),
          ),
        ],
      ),
      backgroundColor: AppTheme.nearlyWhite,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    //Caixinha de pesquisa
                    getSearchBarUI(),
                    //Lista das categorias
                    ProductHorizontalList(),
                  ],
                );
              }, childCount: 1),
            ),
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: ContestTabHeader(
                getFilterBarUI(),
              ),
            ),
          ];
        },
        body: StreamBuilder(
          stream: (produt.isNotEmpty && produt != null)
              ? FirebaseFirestore.instance
                  .collection(PRODUCT)
                  .where(
                    "id_shop",
                    isEqualTo: widget.shopModel.id,
                  )
                  .where("name_product", arrayContains: produt)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection(PRODUCT)
                  .where("id_shop", isEqualTo: widget.shopModel.id)
                  .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Container(
                  child: Center(
                      child: new Text(
                          'Internet fraca. \nPor favar, verifique a sua conexão.')),
                );
              case ConnectionState.waiting:
                return Container(
                  child: Center(child: new CircularProgressIndicator()),
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
                    child: Text('Sem dados'),
                  );
                } else {
                  return snapshot.data.docs.length > 0
                      ? Container(
                          color: AppTheme.nearlyWhite,
                          child: ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            padding: const EdgeInsets.only(top: 8),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return ProductLisView(
                                callback: () => Get.to(() => ProductDetailPage(
                                      item: snapshot.data.docs[index],
                                      shopName:
                                          widget.shopModel['name_shopping'],
                                    )),
                                productData: snapshot.data.docs[index],
                                shopName: widget.shopModel['name_shopping'],
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
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
        padding: EdgeInsets.only(
            left: getProportionateScreenWidth(8),
            right: getProportionateScreenWidth(8),
            top: getProportionateScreenHeight(8),
            bottom: getProportionateScreenHeight(8)),
        child: Padding(
          padding: EdgeInsets.only(
              top: getProportionateScreenHeight(8),
              bottom: getProportionateScreenHeight(8)),
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(4),
                  bottom: getProportionateScreenHeight(4)),
              child: TextField(
                onChanged: (String txt) {
                  setState(() {
                    produt = txt;
                  });
                },
                style: AppTheme.display1,
                cursorColor: AppTheme.nearlyBlack,
                cursorHeight: getProportionateScreenHeight(25),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                  hintText: 'Pesquisar...',
                ),
              ),
            ),
          ),
        ));
  }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Container(
          color: AppTheme.nearlyWhite,
          child: Padding(
            padding: EdgeInsets.only(
                left: getProportionateScreenWidth(16),
                right: getProportionateScreenWidth(16),
                top: getProportionateScreenHeight(8),
                bottom: getProportionateScreenHeight(4)),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Produtos em destaques',
                      style: AppTheme.display1,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.grey.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4.0),
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) =>
                                  FiltersScreen(),
                              fullscreenDialog: true),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Filtros',
                              style: AppTheme.display1,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Icon(Icons.sort, color: AppTheme.cuyutyuBlue),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _getCarts() async {
    final allRows = await dbHelper.getCarts();
    list.clear();
    allRows.forEach((row) => list.add(CartModel.fromMap(row)));
    setState(() {});
  }
}
