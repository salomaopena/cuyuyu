//@dart=2.9
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/models/category/product_category.dart';
import 'package:cuyuyu/src/pages/product_category/product_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CategoryCard extends StatelessWidget {
  final ProductCategory category;
  const CategoryCard({Key key, @required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MQuery = MediaQuery.of(context).size;
    return ChangeNotifierProvider.value(
      value: category,
      child: GestureDetector(
        onTap: () => Get.to(() => ProductCategoryScreen(category: category)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: MQuery.width * 0.5,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 30,
                child: CachedNetworkImage(
                  imageUrl: category.imageUrl,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (_, __, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    valueColor: const AlwaysStoppedAnimation(Colors.deepOrange),
                  )),
                  errorWidget: (context, url, error) => Image.asset(
                    'images/app_logo.png',
                    repeat: ImageRepeat.noRepeat,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Expanded(flex: 10, child: SizedBox(width: 10)),
              Expanded(
                flex: 60,
                child: Text(category.name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
