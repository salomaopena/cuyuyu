//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/components/bottom_nav_bar.dart';
import 'package:cuyuyu/src/components/home_shop_card.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/enums.dart';
import 'package:flutter/material.dart';

class ShopByCategory extends StatefulWidget {
  final QueryDocumentSnapshot category;

  const ShopByCategory({
    Key key,
    this.category,
  }) : super(key: key);

  @override
  _ShopByCategoryState createState() => _ShopByCategoryState();
}

class _ShopByCategoryState extends State<ShopByCategory>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.data()['category'], style: AppTheme.title),
        elevation: 0,
        iconTheme: IconThemeData.fallback(),
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.nearlyBlack,
      ),
      backgroundColor: AppTheme.nearlyWhite,
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
                          padding: const EdgeInsets.only(top: 8),
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            return HomeShopCardView(
                              shop: snapshot.data.docs[index],
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
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }

  Stream<QuerySnapshot> loadAllByCategory(String categoryId) {
    if (categoryId.isNotEmpty || categoryId != null) {
      return FirebaseFirestore.instance
          .collection('Shop')
          .where('shop_category', isEqualTo: categoryId)
          .limit(500)
          .snapshots();
    }
  }
}
