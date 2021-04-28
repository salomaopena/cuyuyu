import 'dart:math';
import 'package:cuyuyu/src/models/product_category.dart';
import 'package:cuyuyu/src/pages/product_by_category.dart';
import 'package:cuyuyu/src/utils/colors.dart';
import 'package:cuyuyu/src/utils/text_scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';


const _horizontalPadding = 24.0;

double desktopLoginScreenMainAreaWidth({BuildContext context}) {
  return min(
    360 * reducedTextScale(context),
    MediaQuery.of(context).size.width - 2 * _horizontalPadding,
  );
}

class ProductHorizontalList extends StatefulWidget {
  @override
  _ProductHorizontalListState createState() => _ProductHorizontalListState();
}

class _ProductHorizontalListState extends State<ProductHorizontalList> {
  List<ProductCategory> categories = [
    ProductCategory(
      id: "01",
      name: "Todas",
      imageUrl: Icon(
        Icons.location_city,
        size: 30,
        color: cuyuyuSurfaceWhite,
      ),
      begin: Color(0xffF749A2),
      end: Color(0xffFF7375),
    ),
    ProductCategory(
      id: "02",
      name: "Bebidas",
      imageUrl: Icon(
        Icons.local_drink,
        size: 30,
        color: cuyuyuSurfaceWhite,
      ),
      begin: Color(0xffF123C4),
      end: Color(0xff668CEA),
    ),
    ProductCategory(
      id: "03",
      name: "Refrigerantes",
      imageUrl: Icon(
        Icons.location_city,
        size: 30,
        color: cuyuyuSurfaceWhite,
      ),
      begin: Color(0xff36E892),
      end: Color(0xff33B2B9),
    ),
    ProductCategory(
      id: "04",
      name: "Alimentos",
      imageUrl: Icon(
        Icons.fastfood,
        size: 30,
        color: cuyuyuSurfaceWhite,
      ),
      begin: Color(0xffFCE183),
      end: Color(0xffF68D7F),
    ),
    ProductCategory(
      id: "05",
      name: "Frio",
      imageUrl: Icon(
        Icons.opacity,
        size: 30,
        color: cuyuyuSurfaceWhite,
      ),
      begin: Color(0xffF749A2),
      end: Color(0xffFF7375),
    ),
    ProductCategory(
      id: "06",
      name: "Qualquer coisa",
      imageUrl: Icon(
        Icons.view_list,
        size: 30,
        color: cuyuyuSurfaceWhite,
      ),
      begin: cuyuyuOrange200,
      end: cuyuyuOrange,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8.0),
        height: MediaQuery.of(context).size.height / 9,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (_, index) => ProdutctCategoryCard(
                  item: categories[index],
                )));
  }
}

class ProdutctCategoryCard extends StatelessWidget {
  final ProductCategory item;

  const ProdutctCategoryCard({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductByCategory(
                category: item,
              ))),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: HexColor('#F8FAFB'),
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 80,
                  width: 90,
                  decoration: BoxDecoration(
                      gradient: RadialGradient(
                          colors: [item.begin, item.end],
                          center: Alignment(0, 0),
                          radius: 0.8,
                          focal: Alignment(0, 0),
                          focalRadius: 0.1),
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: item.imageUrl,
                  ),
                ),
                Container(
                  height: 80,
                  width: 90,
                  padding: EdgeInsets.only(
                      top: 8.0, bottom: 8.0, left: 8.0, right: 0.0),
                  child: Center(
                    child: Text(
                      item.name,
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontFamily: 'Raleway'),
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
