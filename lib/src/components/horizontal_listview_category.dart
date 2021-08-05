//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/pages/product_by_category.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ProductHorizontalList extends StatefulWidget {
  @override
  _ProductHorizontalListState createState() => _ProductHorizontalListState();
}

class _ProductHorizontalListState extends State<ProductHorizontalList> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: loadProdutCategories(),
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
                  itemBuilder: (_, index) {
                    return ProdutctCategoryCard(
                      item: snapshot.data.docs[index],
                    );
                  },
                ),
              );
            }
        }
      },
    );
  }


  Stream<QuerySnapshot> loadProdutCategories() {
    return FirebaseFirestore.instance
        .collection(PRODUCT_CATEGORY)
        .orderBy('name_product_category', descending: false)
        .limit(100)
        .snapshots();
  }
}

class ProdutctCategoryCard extends StatelessWidget {
  final QueryDocumentSnapshot  item;

  const ProdutctCategoryCard({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: getProportionateScreenWidth(10),
            right: getProportionateScreenWidth(10)),
      child: GestureDetector(
        onTap: () => Get.to(()=> ProductByCategory(category: item)),
        child: SizedBox(
          width: getProportionateScreenWidth(242),
          height: getProportionateScreenHeight(100),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Stack(
                children: <Widget>[
                  Image.network(
                    item.data()['image_url_product_category'],
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    repeat: ImageRepeat.noRepeat,
                    width:  double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppTheme.nearlyBlack.withOpacity(0.9),
                          AppTheme.nearlyBlack.withOpacity(0.15),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(15.0),
                      vertical: getProportionateScreenWidth(10),
                    ),
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: item.data()['name_product_category']+"\n",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(text: "Tudo que voce deseja")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

        ),
      ),
    );
  }
}
