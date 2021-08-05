//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/components/category_card.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopHorizontalList extends StatefulWidget {
  @override
  _ShopHorizontalListState createState() => _ShopHorizontalListState();
}

class _ShopHorizontalListState extends State<ShopHorizontalList> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: loadShopCategories(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                height: getProportionateScreenHeight(110),
                width: double.infinity,
                color: AppTheme.nearlyWhite,
                child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategoryCardShop(
                      category: snapshot.data.docs[index],
                    );
                  },
                ),
              );
            }
        }
      },
    );
  }

  Stream<QuerySnapshot> loadShopCategories() {
    return FirebaseFirestore.instance
        .collection(SHOP_CATEGORY)
        .orderBy('category', descending: false)
        .limit(15)
        .snapshots();
  }
}
