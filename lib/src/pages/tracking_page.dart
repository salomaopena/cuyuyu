import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/components/shopping_list_view.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'order_detail_page.dart';
class TrackingPage extends StatefulWidget {
  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
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
                child: getTrackingList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTrackingList() {
    return FirebaseAuth.instance.currentUser!=null? FutureBuilder(
      future: readShoppingList(),
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
                      color: ShopAppTheme.buildLightTheme().backgroundColor,
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 8.0),
                        itemCount: snapshot.data.docs.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          final int count = snapshot.data.docs.length > 10
                              ? 10
                              : snapshot.data.docs.length;
                          final Animation<double> animation =
                              Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                      parent: animationController,
                                      curve: Interval((1 / count) * index, 1.0,
                                          curve: Curves.fastOutSlowIn)));
                          animationController.forward();
                          return ShoppingListView(
                            callback: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OrderDetailPage(
                                        item: snapshot.data.docs[index],
                                      )));
                            },
                            shopping: snapshot.data.docs[index],
                            animation: animation,
                            animationController: animationController,
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
    ):Container(
      child: Center(child: Text('Ainda não efectuuou uma compra.')),
    );
  }

  Future<QuerySnapshot> readShoppingList() async {
    var query = await FirebaseFirestore.instance
        .collection(ORDERS)
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get();
    return query;
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
                  'Pedidos',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    fontFamily: 'Raleway',
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
}
