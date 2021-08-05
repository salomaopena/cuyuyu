//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/components/home_shop_card.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:flutter/material.dart';

class HomeShopListView extends StatelessWidget {
  const HomeShopListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: loadAllShops(),
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  child: Text(snapshot.error.toString()),
                ),
              );
            } else if (!snapshot.hasData) {
              return Container(
                child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    )),
              );
            } else {
              return Container(
                width: double.infinity,
                color: AppTheme.nearlyWhite,
                child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return HomeShopCardView(
                      shop: snapshot.data.docs[index],
                    );
                  },
                ),
              );
            }
        }
      },
    );
  }

  Stream<QuerySnapshot> loadAllShops() {
    return FirebaseFirestore.instance
        .collection(SHOP_URL)
        .orderBy(ShopAttributes.NAME, descending: false)
        .limit(50)
        .snapshots();
  }
}
