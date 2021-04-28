import 'package:cuyuyu/src/models/shop_category.dart';
import 'package:cuyuyu/src/pages/shop_by_category.dart';
import 'package:flutter/material.dart';



class CategoryCardShop extends StatelessWidget {
  final ShopCategoryModel category;

  const CategoryCardShop({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ShopByCategory(
                category: category,
              ))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 80,
                  width: 90,
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      category.category,
                      textAlign: TextAlign.right,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontFamily: 'Raleway'),
                    ),
                  ),
                ),
                Container(
                  height: 80,
                  width: 90,
                  decoration: BoxDecoration(
                      gradient: RadialGradient(
                          colors: [category.begin, category.end],
                          center: Alignment(0, 0),
                          radius: 0.8,
                          focal: Alignment(0, 0),
                          focalRadius: 0.1)),
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: category.image,
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
