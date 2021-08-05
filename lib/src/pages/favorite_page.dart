//@dart=2.9
import 'package:cuyuyu/src/components/bottom_nav_bar.dart';
import 'package:cuyuyu/src/models/wish_list.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/databases/database_app.dart';
import 'package:cuyuyu/src/utils/enums.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:cuyuyu/src/utils/smooth_star_rating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
    with TickerProviderStateMixin {

  final dbHelper = DatabaseApp.instance;
  final List<WishListModel> list = [];

  @override
  void initState() {
    setState(() {
      _favoriteList();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Meus favoritos",
          style: AppTheme.title,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.nearlyBlack,
      ),
      backgroundColor: AppTheme.nearlyWhite,
            body: Stack(
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: getFavoriteList(),
                      )
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.favorite),
    );
  }

  void _favoriteList() async {
    final allRows = await dbHelper.getFavorites();
    list.clear();
    allRows.forEach((row) => list.add(WishListModel.fromMap(row)));
    setState(() {});
  }

  Widget getFavoriteList() {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.only(left: 6.0, right: 6.0, top: 8.0, bottom: 8.0),
        itemCount: list.length,
        itemBuilder: (context, index) {
          WishListModel item = list[index];
          return list.length > 0
              ? Container(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              color: ShopAppTheme.buildLightTheme()
                                  .backgroundColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Card(
                                        elevation: 0.5,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              height: getProportionateScreenHeight(125),
                                              width: getProportionateScreenWidth(110),
                                              padding: EdgeInsets.only(
                                                  left: getProportionateScreenWidth(0),
                                                  top: getProportionateScreenHeight(10),
                                                  bottom: getProportionateScreenHeight(70),
                                                  right: getProportionateScreenWidth(20)),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: item.image !=
                                                                  null ||
                                                              item.image
                                                                  .isNotEmpty
                                                          ? NetworkImage(
                                                              item.image)
                                                          : AssetImage(
                                                              'images/app_logo.png'),
                                                      fit: BoxFit.cover)),
                                              child: item.discount == null
                                                  ? Container()
                                                  : Container(
                                                      color: Colors.deepOrange,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            '${item.discount}%',
                                                            style: AppTheme.body2,
                                                          ),
                                                          Text(
                                                            "Promoção",
                                                            style: AppTheme.body2,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      item.name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppTheme.display4.copyWith(
                                                          color: AppTheme
                                                              .cuyuyuOrange,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: 'Muli'),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Text(
                                                            '\Kz ${double.parse(item.oldPrice)}',
                                                            style: AppTheme.body1.copyWith(
                                                              color: Colors.red
                                                                  .withOpacity(
                                                                      0.8),
                                                              fontFamily:
                                                                  'Muli',
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            '\Kz ${double.parse(item.price)}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: AppTheme.body1
                                                                .copyWith(
                                                                  fontFamily:
                                                                      'Muli',
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child:
                                                                SmoothStarRating(
                                                              allowHalfRating:
                                                                  true,
                                                              starCount: 5,
                                                              //rating: hotelData.rating,
                                                              rating: 80,
                                                              size: 20,
                                                              color: ShopAppTheme
                                                                      .buildLightTheme()
                                                                  .primaryColor,
                                                              borderColor: ShopAppTheme
                                                                      .buildLightTheme()
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              'Pedido mínimo ${item.minimumNumber}',
                                                              style: AppTheme.body1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                              onTap: () {
                                setState(() {
                                  deleteFavorite(item);
                                  _favoriteList();
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: new Text('Removido dos favoritos'),
                                  ));
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.favorite,
                                  color: AppTheme.cuyutyuBlue,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CupertinoActivityIndicator(),
                );
        },
      ),
    );
  }


  void deleteFavorite(WishListModel item) async {
    await dbHelper.removeFromFavorite(item);
  }
}
