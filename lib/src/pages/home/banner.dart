//@dart=2.9
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Container(
      margin: EdgeInsets.only(
        top: 4.0,
        bottom: 8.0,
      ),
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      height: getProportionateScreenHeight(160),
      width: double.infinity,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection(BANNER_URL).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            List<NetworkImage> list = []..length;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Container(
                  child: Center(
                      child: new Text(
                          'Internet fraca. \nPor favar, verifique a sua conexão.')),
                );
                break;
              case ConnectionState.waiting:
                return Container(
                  child: Center(child: new CircularProgressIndicator()),
                );
                break;
              default:
                if (snapshot.hasError) {
                  return Container(
                    child: Center(
                      child: Text(snapshot.error.toString()),
                    ),
                  );
                } else if (snapshot.hasData) {
                  for (int i = 0; i < snapshot.data.size; i++) {
                    list.add(NetworkImage(
                        snapshot.data.docs[i].data()['image_url']));
                    index = i;
                  }
                  return GestureDetector(
                    onTap: () {
                      print("Clicado");
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      child: Banner(
                        message: "Publicite aqui",
                        location: BannerLocation.topEnd,
                        color: Colors.red,
                        child: Stack(
                          children: [
                            Carousel(
                              boxFit: BoxFit.cover,
                              images: list,
                              autoplay: true,
                              radius: Radius.circular(20),
                              borderRadius: true,
                              dotSpacing: 20,
                              animationCurve: Curves
                                  .fastLinearToSlowEaseIn, //Curves.fastLinearToSlowEaseIn,
                              animationDuration: Duration(milliseconds: 5000),
                              dotSize: 2.0,
                              dotColor: AppTheme.cuyuyuOrange400,
                              dotBgColor: AppTheme.cuyuyuTransparent,
                              indicatorBgPadding: 2.0,
                              overlayShadow: true,
                              overlayShadowColors: AppTheme.cuyuyuOrange100,
                              overlayShadowSize: 0.4,
                            ),
                            Padding(
                              padding: EdgeInsets.all(getProportionateScreenHeight(10)),
                              child: Text(snapshot.data.docs[index].data()['offer'],
                                style: AppTheme.title.copyWith(
                                  fontFamily: 'Muli',
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.red
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            }
            return Container();
          }),
    );
  }
}
