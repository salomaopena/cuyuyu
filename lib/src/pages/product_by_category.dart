//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/components/bottom_nav_bar.dart';
import 'package:cuyuyu/src/components/product_listview.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/enums.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductByCategory extends StatefulWidget {
  final QueryDocumentSnapshot category;

  const ProductByCategory({Key key, this.category}) : super(key: key);

  @override
  _ProductByCategoryState createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory>
    with TickerProviderStateMixin {


  @override
  void initState() {
    print('Category Id: '+widget.category.id);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData.fallback(),
            centerTitle: true,
            title: Text(
              "${widget.category.data()['name_product_category']}",
              style: AppTheme.title,
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: AppTheme.nearlyBlack,
          ),
          backgroundColor: AppTheme.nearlyWhite,
          body: NestedScrollView(
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
                                          color: AppTheme.nearlyWhite,
                                          child: ListView.builder(
                                            padding: EdgeInsets.only(top: 8.0),
                                            itemCount:
                                                snapshot.data.docs.length,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return ProductLisView(
                                                callback: () {
                                                },
                                                productData:
                                                    snapshot.data.docs[index],
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

  Future<QuerySnapshot> loadProductByCategory(String categoryId) {
    if (categoryId.isNotEmpty || categoryId != null) {
      return FirebaseFirestore.instance
          .collection(PRODUCT)
          .where('product_category_id', isEqualTo: categoryId)
          .get();
    }
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

}
