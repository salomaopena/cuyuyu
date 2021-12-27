//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/common/empty_card.dart';
import 'package:cuyuyu/src/models/products/product_manager.dart';
import 'package:cuyuyu/src/models/stores/store.dart';
import 'package:cuyuyu/src/pages/cart/cart_screen.dart';
import 'package:cuyuyu/src/pages/home/components/search_dialog.dart';
import 'package:cuyuyu/src/pages/product_category/components/product_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProductStoreSreen extends StatelessWidget {

  final Stores store;

  const ProductStoreSreen({this.store});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value:store,
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<ProductManager>(
            builder: (_, ProductManager productManager, __) {
              if (productManager.search.isEmpty) {
                return Text(
                  store.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.closeColor,
                    fontWeight: FontWeight.w700,
                  ),
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
                    child: Container(
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
                  icon: Icon(
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
                  icon: Icon(
                    Icons.close,
                    color: AppColors.closeColor,
                  ),
                  onPressed: () async {
                    productManager.search = '';
                  },
                );
              }
            }),
          ],
        ),
        body: Consumer<ProductManager>(builder: (_, productManager, __) {
          final filteredProducts =
          productManager.filteredProductsByStore(store.id);
          if (filteredProducts.length == 0) {
            return EmptyCard(
                icon: Icons.hourglass_empty,
                title:
                'Nenhum produto cadastrado para a Loja ${store.name}');
          }
          return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: filteredProducts.length,
              itemBuilder: (_, index) {
                return ProductListTile(product: filteredProducts[index]);
              });
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          foregroundColor: Colors.deepOrange,
          onPressed: () {
            Get.to(() => CartScreen());
          },
          child: const Icon(Icons.shopping_cart),
        ),
      ),
    );
  }
}
