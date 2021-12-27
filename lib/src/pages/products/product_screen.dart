//@dart=2.9
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/models/products/product_manager.dart';
import 'package:cuyuyu/src/models/users/user_manager.dart';
import 'package:cuyuyu/src/pages/cart/cart_screen.dart';
import 'package:cuyuyu/src/pages/home/components/custom_drawer.dart';
import 'package:cuyuyu/src/pages/home/components/search_dialog.dart';
import 'package:cuyuyu/src/pages/product_details/product_detail_screen.dart';
import 'package:cuyuyu/src/pages/products/product_addscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Consumer<ProductManager>(
          builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return const Text(
                'Produtos',
                style: TextStyle(
                    color: AppColors.closeColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              );
            } else {
              return LayoutBuilder(builder: (_, constraints) {
                return GestureDetector(
                  onTap: () async {
                    final search = await showDialog<String>(
                        context: context,
                        builder: (_) => SearchDialog(productManager.search));
                    if (search != null) {
                      productManager.search = search;
                    }
                  },
                  child: SizedBox(
                      width: constraints.biggest.width,
                      child: Text(
                        productManager.search,
                        textAlign: TextAlign.center,
                      )),
                );
              });
            }
          },
        ),
        actions: [
          Consumer<ProductManager>(builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return IconButton(
                icon: const Icon(
                  Icons.search,
                  color: AppColors.closeColor,
                ),
                onPressed: () async {
                  final search = await showDialog<String>(
                      context: context,
                      builder: (_) => SearchDialog(productManager.search));
                  if (search != null) {
                    productManager.search = search;
                  }
                },
              );
            } else {
              return IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.deepOrange,
                ),
                onPressed: () async {
                  productManager.search = '';
                },
              );
            }
          }),
          Consumer<UserManager>(builder: (_, userManager, __) {
            if (userManager.adminEnabled) {
              return IconButton(
                onPressed: () {
                  Get.to(() => ProductAddScreen());
                },
                icon: const Icon(Icons.add, color: AppColors.closeColor),
              );
            } else {
              return Container();
            }
          })
        ],
      ),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __) {
          final filteredProducts = productManager.filteredProducts;
          if (filteredProducts.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.deepOrange),
                backgroundColor: Colors.transparent,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: StaggeredGridView.countBuilder(
              padding: EdgeInsets.zero,
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              itemCount: filteredProducts.length,
              itemBuilder: (_, index) {
                final product = filteredProducts[index];
                return GestureDetector(
                  onTap: () {
                    if (product != null) {
                      final productFound =
                          productManager.findProductById(product.id);
                      if (productFound != null) {
                        Get.to(() => ProductDetailScreen(
                              product: productFound,
                            ));
                      }
                    }
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Center(
                                child: CachedNetworkImage(
                                  imageUrl: product.image,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder: (_, __,
                                          DownloadProgress downloadProgress) =>
                                      Center(
                                          child: CircularProgressIndicator(
                                    value: downloadProgress.progress,
                                    valueColor: const AlwaysStoppedAnimation(
                                        Colors.deepOrange),
                                  )),
                                  errorWidget: (_, __, ___) => Image.asset(
                                    'images/app_logo.png',
                                    repeat: ImageRepeat.noRepeat,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: AppColors.nearlyBlack,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'A partir de',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 11),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${product.basePrice.toStringAsFixed(2)}Kz',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.closeColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (index) =>
                  StaggeredTile.count(2, index.isEven ? 2.5 : 1.7),
              //new StaggeredTile.count(1, index.isEven ? 1.7 : 1.3),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepOrange,
        onPressed: () {
          Get.to(() => CartScreen());
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
