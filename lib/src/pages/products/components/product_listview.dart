//@dart=2.9
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/models/products/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProductLisView extends StatelessWidget {
  final ProductModel product;

  const ProductLisView({this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Get.to(() => ProductDetailScreen(product: product))
      },
      child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 0,
          child: Row(
            children: [
              SizedBox(
                width: 88,
                child: AspectRatio(
                  aspectRatio: 0.88,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (_, __, DownloadProgress downloadProgress) => Center(
                              child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        valueColor:
                            const AlwaysStoppedAnimation(Colors.deepOrange),
                      )),
                      errorWidget: (_, __, ___) => Image.asset(
                        'images/app_logo.png',
                        repeat: ImageRepeat.noRepeat,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 10),
                  Text.rich(
                    TextSpan(
                      text: '${product.basePrice.toStringAsFixed(2)}Kz\n',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.closeColor),
                      children: [
                        TextSpan(
                          text:
                              '${double.parse(product.oldPrice).toStringAsFixed(2)}Kz',
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Color(0xFFF00000),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
