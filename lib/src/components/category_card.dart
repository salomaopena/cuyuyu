//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/pages/shop_by_category.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryCardShop extends StatelessWidget {
  final QueryDocumentSnapshot category;

  const CategoryCardShop({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: getProportionateScreenWidth(10),
          right: getProportionateScreenWidth(10)),
      child: GestureDetector(
        onTap: () =>  Get.to(()=>ShopByCategory(category: category)),
        child: SizedBox(
          width: getProportionateScreenWidth(242),
          height: getProportionateScreenHeight(100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(
                  category.data()['image'],
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
                          text: category.data()['category']+"\n",
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
