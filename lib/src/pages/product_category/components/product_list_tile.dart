import 'package:cached_network_image/cached_network_image.dart';
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/models/products/product.dart';
import 'package:cuyuyu/src/pages/product_details/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 0,
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.medium,
                  progressIndicatorBuilder: (_,
                      __,
                      DownloadProgress
                      downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                            valueColor:
                            const AlwaysStoppedAnimation(
                                Colors.deepOrange),
                          )),
                  errorWidget: (_, __, ___) => Image.asset(
                    'images/app_logo.png',
                    repeat: ImageRepeat.noRepeat,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'A partir de ',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Text(
                      '${product.basePrice.toStringAsFixed(2)} Kz',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.closeColor,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
