//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/pages/produtc_home_page.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:cuyuyu/src/utils/smooth_star_rating.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';


class HomeShopCardView extends StatelessWidget {
  const HomeShopCardView({Key key, this.shop}) : super(key: key);
  final QueryDocumentSnapshot shop;

  @override
  Widget build(BuildContext context) {
    RxBool isLoading = false.obs;
    return Padding(
      padding: EdgeInsets.only(
          bottom: getProportionateScreenHeight(10),
          top: getProportionateScreenHeight(10),
          left: getProportionateScreenWidth(10),
          right: getProportionateScreenWidth(10)),
      child: isLoading.isFalse
          ? GestureDetector(
              onTap: () {
                isLoading.isTrue;
                Get.to(()=> ProdutHomePage(shopModel: shop));
              },
              child: SizedBox(
                width: double.infinity,
                height: getProportionateScreenWidth(150),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      Image.network(
                        shop.data()['image_url_shop'],
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        repeat: ImageRepeat.noRepeat,
                        width: double.infinity,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(shop.data()['name_shopping'],
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(20),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Muli',
                                ),
                                overflow: TextOverflow.ellipsis),
                            SizedBox(height: getProportionateScreenHeight(5)),
                            Text(shop.data()['address_shop']),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: SmoothStarRating(
                                      allowHalfRating: true,
                                      starCount: 5,
                                      //rating: hotelData.rating,
                                      rating: 80,
                                      size: 20,
                                      color: AppTheme.nearlyGreen,
                                      borderColor: AppTheme.redColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 8,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(32.0),
                            ),
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
