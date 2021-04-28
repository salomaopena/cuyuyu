import 'package:cuyuyu/src/components/category_card.dart';
import 'package:cuyuyu/src/models/shop_category.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopHorizontalList extends StatefulWidget {
  @override
  _ShopHorizontalListState createState() => _ShopHorizontalListState();
}

class _ShopHorizontalListState extends State<ShopHorizontalList> {
  List<ShopCategoryModel> categories = [
    ShopCategoryModel(
      id: "01",
      begin: Color(0xffFCE183),
      end: Color(0xffF68D7F),
      category: 'Lojas',
      image: Icon(
        Icons.business,
        size: 30,
        color: AppTheme.cuyuyuSurfaceWhite,
      ),
    ),
    ShopCategoryModel(
      id: "02",
      begin: Color(0xffF749A2),
      end: Color(0xffFF7375),
      category: 'Refeições e Lanches',
      image: Icon(
        Icons.fastfood,
        size: 30,
        color: AppTheme.cuyuyuSurfaceWhite,
      ),
    ),
    ShopCategoryModel(
      id: "03",
      begin: AppTheme.cuyuyuOrange200,
      end: AppTheme.cuyuyuOrange,
      category: 'Boutiques e Cosméticos',
      image: Icon(
        Icons.shopping_basket,
        size: 30,
        color: AppTheme.cuyuyuSurfaceWhite,
      ),
    ),
    ShopCategoryModel(
      id: "04",
      begin: AppTheme.cuyuyuLigthBlue,
      end: AppTheme.cuyutyuBlue,
      category: 'Lojas de conveniência',
      image: Icon(
        Icons.category,
        size: 30,
        color: AppTheme.cuyuyuSurfaceWhite,
      ),
    ),
    ShopCategoryModel(
      id: "05",
      begin: Color(0xff36E892),
      end: Color(0xff33B2B9),
      category: 'Peças e acessórios',
      image: Icon(
        Icons.build,
        size: 30,
        color: AppTheme.cuyuyuSurfaceWhite,
      ),
    ),
    ShopCategoryModel(
      id: "06",
      begin: Color(0xffF123C4),
      end: Color(0xff668CEA),
      category: 'Farmácias',
      image: Icon(
        Icons.local_hospital,
        size: 30,
        color: AppTheme.cuyuyuSurfaceWhite,
      ),
    ),
    ShopCategoryModel(
      id: "07",
      begin: AppTheme.cuyuyuYellow,
      end: AppTheme.cuyuyuDarkYellow,
      category: 'Peixarias e Talhos',
      image: Icon(
        Icons.blur_linear,
        size: 30,
        color: AppTheme.cuyuyuSurfaceWhite,
      ),
    ),
    ShopCategoryModel(
      id: "08",
      begin: Color(0xffF749A2),
      end: Color(0xffFF7375),
      category: 'Frutarias',
      image: Icon(
        Icons.style,
        size: 30,
        color: AppTheme.cuyuyuSurfaceWhite,
      ),
    ),
    ShopCategoryModel(
      id: "09",
      begin: Color(0xff36E892),
      end: Color(0xff33B2B9),
      category: 'Outros',
      image: Icon(
        Icons.assignment,
        size: 30,
        color: AppTheme.cuyuyuSurfaceWhite,
      ),
    ),
  ];

  var position = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height / 9,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        // ignore: missing_return
        itemBuilder: (context, index) {
          position = index;
          return CategoryCardShop(
            category: categories[index],
          );
        },
      ),
    );
  }
}
