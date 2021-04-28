import 'dart:ui';
import 'package:badges/badges.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/components/horizontal_listview.dart';
import 'package:cuyuyu/src/components/hotel_list_view.dart';
import 'package:cuyuyu/src/models/cart_model.dart';
import 'package:cuyuyu/src/models/shop.dart';
import 'package:cuyuyu/src/pages/produtc_home_page.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/colors.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/databases/database_app.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:flutter/material.dart';

import 'cart_page.dart';

const ID = "id";
const NAME = "name_shopping";
const LATITUDE = "latitude_shop";
const LOGITUDE = "longitude_shop";
const PHONE_NUMBER = "phone_number_shop";
const EMAIL = "email_shop";
const IMAGE = "image_url_shop";
const ADDRESS = "address_shop";
const OPEN_AT = "open_at_shop";
const CLOSE_AT = "close_at_shop";
const IS_OPEN = "is_open_shop";
const CATEGORY = "shop_category";

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key key}) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  bool multiple = true;

  List<ShopModel> shops = List();
  List<CartModel> list = List();
  List<NetworkImage> listOfImages = List();
  final dbHelper = DatabaseApp.instance;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    setState(() {
      _getCarts();
    });
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: ShopAppTheme.buildLightTheme(),
        child: Container(
          child: Scaffold(
            backgroundColor: AppTheme.white,
            body: Stack(
              children: <Widget>[
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Column(
                    children: <Widget>[
                      appBar(),
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
                                      getTimeDateUI(),
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
                            stream: loadAllShops(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return const SizedBox();
                              } else {
                                return snapshot.data.docs.length > 0
                                    ? Container(
                                        color: ShopAppTheme.buildLightTheme()
                                            .backgroundColor,
                                        child: ListView.builder(
                                          itemCount: snapshot.data.docs.length,
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            final int count =
                                                snapshot.data.docs.length > 10
                                                    ? 10
                                                    : snapshot.data.docs.length;
                                            final Animation<
                                                double> animation = Tween<
                                                        double>(
                                                    begin: 0.0, end: 1.0)
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
                                                    builder: (BuildContext
                                                            context) =>
                                                        ProdutHomePage(
                                                            shopModel: snapshot
                                                                .data
                                                                .docs[index]),
                                                  ),
                                                );
                                              },
                                              hotelData:
                                                  snapshot.data.docs[index],
                                              animation: animation,
                                              animationController:
                                                  animationController,
                                            );
                                          },
                                        ),
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor:
                                              AppTheme.cuyuyuOrange,
                                        ),
                                      );
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stream<QuerySnapshot> loadAllShops() {
    return FirebaseFirestore.instance
        .collection('Shop')
        .orderBy('name_shopping', descending: true)
        .snapshots();
  }

  Widget getTimeDateUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
      child: Column(
        children: <Widget>[
          banner(),
          ShopHorizontalList(),
        ],
      ),
    );
  }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: ShopAppTheme.buildLightTheme().backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: ShopAppTheme.buildLightTheme().backgroundColor,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Lojas adicionadas recentemente',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Cuyuyu Entregas',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppTheme.dark_grey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: IconButton(
                    icon: Badge(
                      badgeContent: Text(
                        '${list.length}',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: cuyuyuSurfaceWhite,
                              fontFamily: 'Raleway',
                            ),
                      ),
                      child: Icon(
                        Icons.shopping_cart,
                        color: AppTheme.darkerText,
                        size: 30,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CartPage()));
                      setState(() {
                        _getCarts();
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget banner() {
    return Container(
      margin: EdgeInsets.only(top: 4.0, bottom: 8.0),
      height: MediaQuery.of(context).size.height / 4.3,
      color: AppTheme.cuyuyuTransparent,
      child: StreamBuilder<QuerySnapshot>(
          stream: loadBanners(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return ClipRect(
                  child: Banner(
                    message: "Publicite aqui",
                    location: BannerLocation.topEnd,
                    color: Colors.red,
                    child: Carousel(
                      boxFit: BoxFit.cover,
                      images: [
                        NetworkImage(
                            'https://cdn.pixabay.com/photo/2014/08/05/10/32/ice-cream-410330__340.jpg'),
                        NetworkImage(
                            'https://cdn.pixabay.com/photo/2018/11/11/19/27/herbs-3809512__340.jpg'),
                        NetworkImage(
                            'https://cdn.pixabay.com/photo/2019/11/07/09/12/smoothies-4608349__340.jpg'),
                      ],
                      autoplay: true,
                      animationCurve: Curves.fastLinearToSlowEaseIn,
                      animationDuration: Duration(milliseconds: 2000),
                      dotSize: 2.0,
                      dotColor: cuyuyuOrange400,
                      dotBgColor: cuyuyuTransparent,
                      indicatorBgPadding: 2.0,
                    ),
                  ),
                );
                break;
              default:
                return ClipRect(
                  child: Banner(
                    message: "Publicite aqui",
                    location: BannerLocation.topEnd,
                    color: Colors.red,
                    child: Carousel(
                      boxFit: BoxFit.cover,
                      images: [
                        NetworkImage(
                            'https://cdn.pixabay.com/photo/2014/08/05/10/32/ice-cream-410330__340.jpg'),
                        NetworkImage(
                            'https://cdn.pixabay.com/photo/2018/11/11/19/27/herbs-3809512__340.jpg'),
                        NetworkImage(
                            'https://cdn.pixabay.com/photo/2019/11/07/09/12/smoothies-4608349__340.jpg')
                      ],
                      autoplay: true,
                      animationCurve: Curves.fastLinearToSlowEaseIn,
                      animationDuration: Duration(milliseconds: 2000),
                      dotSize: 2.0,
                      dotColor: cuyuyuOrange400,
                      dotBgColor: cuyuyuTransparent,
                      indicatorBgPadding: 2.0,
                    ),
                  ),
                );
              /*if (snapshot.hasData) {
                  return Container(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Banner(
                              color: Colors.red,
                              message: snapshot.data.docs[index]['offer'],
                              location: BannerLocation.topEnd);
                        }),
                  );
                }*/
            }
          }),
    );
  }

  Stream<QuerySnapshot> loadBanners() {
    return FirebaseFirestore.instance.collection(BANNER_URL).snapshots();
  }

  void _getCarts() async {
    final allRows = await dbHelper.getCarts();
    list.clear();
    allRows.forEach((row) => list.add(CartModel.fromMap(row)));
    setState(() {});
  }
}
