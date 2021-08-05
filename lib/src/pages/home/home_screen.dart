//@dart=2.9
import 'dart:async';

import 'package:cuyuyu/src/components/bottom_nav_bar.dart';
import 'package:cuyuyu/src/components/home_shop_listview.dart';
import 'package:cuyuyu/src/components/horizontal_listview.dart';
import 'package:cuyuyu/src/models/cart_model.dart';
import 'package:cuyuyu/src/pages/home/banner.dart';
import 'package:cuyuyu/src/pages/chat_page.dart';
import 'package:cuyuyu/src/pages/home/top_bar_ui.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/config.dart';
import 'package:cuyuyu/src/utils/databases/database_app.dart';
import 'package:cuyuyu/src/utils/enums.dart';
import 'package:cuyuyu/src/utils/icon_badge.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

import '../cart_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Position _position;
  StreamSubscription<Position> _streamSubscription;

  List<CartModel> list = []..length;
  final dbHelper = DatabaseApp.instance;

  @override
  void initState() {
    _getCarts();

    _streamSubscription = Geolocator.getPositionStream(
        desiredAccuracy: LocationAccuracy.high, distanceFilter: 10)
        .listen((Position position) {
      setState(() {
        print(position);
        if(_position!=null) {
          _position = position;
          final coordinates = Coordinates(
              position.latitude, position.longitude);
          convertCoordinateToAddress(coordinates)
              .then((value) => value);
        }else{
          final coordinates = Coordinates(
              -14.9213891, 13.4858733);
          convertCoordinateToAddress(coordinates)
              .then((value)=>value);
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cuyuyu Entregas",
          style: AppTheme.title.copyWith(
              fontWeight: FontWeight.w800, fontFamily: 'Muli', fontSize: 22),
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
                    SizedBox(height: getProportionateScreenHeight(10)),
                    HomeBanner(),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    ShopHorizontalList(),
                    SizedBox(height: getProportionateScreenWidth(10)),
                  ],
                );
              }, childCount: 1),
            ),
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: ContestTabHeader(
                TopBarUI(),
              ),
            ),
          ];
        },
        body: HomeShopListView(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.cuyuyuOrange,
        foregroundColor: AppTheme.nearlyWhite,
        child: Icon(Icons.message_outlined),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HelpPage(),
          ));
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }

  void _getCarts() async {
    final allRows = await dbHelper.getCarts();
    list.clear();
    allRows.forEach((row) => list.add(CartModel.fromMap(row)));
  }


  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  Future<Address> convertCoordinateToAddress(Coordinates coordinates) async {
    var address =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return address.first;
  }
}
