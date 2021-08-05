//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/components/bottom_nav_bar.dart';
import 'package:cuyuyu/src/components/shopping_list_view.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'order_detail_page.dart';

class TrackingPage extends StatefulWidget {
  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedidos efectuados", style: AppTheme.title),
        elevation: 0,
        iconTheme: IconThemeData.fallback(),
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.nearlyBlack,
      ),
      backgroundColor: AppTheme.nearlyWhite,
      body: Column(
        children: [
          Expanded(
            child: getTrackingList(),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }

  Widget getTrackingList() {
    return FirebaseAuth.instance.currentUser != null
        ? FutureBuilder(
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
                            color: AppTheme.nearlyWhite,
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.only(top: 8.0),
                              itemCount: snapshot.data.docs.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                return ShoppingListView(
                                  callback: () => Get.to(() => OrderDetailPage(
                                        item: snapshot.data.docs[index],
                                      )),
                                  shopping: snapshot.data.docs[index],
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
          )
        : Container(
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
}
