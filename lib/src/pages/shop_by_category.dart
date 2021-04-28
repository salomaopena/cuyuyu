import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/components/hotel_list_view.dart';
import 'package:cuyuyu/src/models/shop.dart';
import 'package:cuyuyu/src/models/shop_category.dart';
import 'package:cuyuyu/src/pages/produtc_home_page.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class ShopByCategory extends StatefulWidget {
  final ShopCategoryModel category;

  const ShopByCategory({Key key, this.category}) : super(key: key);

  @override
  _ShopByCategoryState createState() => _ShopByCategoryState();
}

class _ShopByCategoryState extends State<ShopByCategory>
    with TickerProviderStateMixin {
  AnimationController animationController;
  bool multiple = true;

  List<ShopModel> lists = List();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    FirebaseDatabase.instance
        .reference()
        .child(SHOP_URL)
        .orderByChild("shop_category")
        .equalTo(widget.category.id)
        .once()
        .then((DataSnapshot snapshot) {
      var keys = snapshot.value.keys;
      var value = snapshot.value;
      lists.clear();
      for (var key in keys) {
        ShopModel shop = new ShopModel(
            addressShop: value[key][ADDRESS],
            closeAtShop: value[key][CLOSE_AT],
            emailShop: value[key][EMAIL],
            imageUrlShop: value[key][IMAGE],
            isOpenShop: value[key][IS_OPEN],
            latitudeShop: value[key][LATITUDE],
            longitudeShop: value[key][LOGITUDE],
            nameShopping: value[key][NAME]);
        lists.add(shop);
      }
      setState(() {
        print('Total : ${lists.length}');
      });
    });
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ShopAppTheme.buildLightTheme().backgroundColor,
      child: SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
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
                            children: <Widget>[],
                          );
                        }, childCount: 1),
                      ),
                    ];
                  },
                  body: StreamBuilder(
                    stream: loadAllByCategory(widget.category.id),
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
                            child:
                                Center(child: new CircularProgressIndicator()),
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
                                    color: ShopAppTheme.buildLightTheme()
                                        .backgroundColor,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.only(top: 8),
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        final int count =
                                            snapshot.data.docs.length > 10
                                                ? 10
                                                : snapshot.data.docs.length;
                                        final Animation<double> animation =
                                            Tween<double>(begin: 0.0, end: 1.0)
                                                .animate(CurvedAnimation(
                                                    parent: animationController,
                                                    curve: Interval(
                                                        (1 / count) * index,
                                                        1.0,
                                                        curve: Curves
                                                            .fastOutSlowIn)));
                                        animationController.forward();
                                        return HotelListView(
                                          callback: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        ProdutHomePage(
                                                            shopModel: snapshot
                                                                .data
                                                                .docs[index]),
                                              ),
                                            );
                                          },
                                          hotelData: snapshot.data.docs[index],
                                          animation: animation,
                                          animationController:
                                              animationController,
                                        );
                                      },
                                    ),
                                  )
                                : Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                          }
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Stream<QuerySnapshot> loadAllByCategory(String categoryId) {
    if (categoryId.isNotEmpty || categoryId != null) {
      return FirebaseFirestore.instance
          .collection('Shop')
          .where('shop_category', isEqualTo: categoryId)
          .limit(50)
          .snapshots();
    }
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: ShopAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.0),
              offset: const Offset(0, 0),
              blurRadius: 0.0),
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
                  widget.category.category,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    fontFamily: 'Raleway',
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 10,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }
}
