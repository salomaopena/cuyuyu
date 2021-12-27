//@dart=2.9
import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/models/cart/cart_manager.dart';
import 'package:cuyuyu/src/models/products/product.dart';
import 'package:cuyuyu/src/models/users/user_manager.dart';
import 'package:cuyuyu/src/pages/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;
  const ProductDetailScreen({this.product});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(product.name,
              style: const TextStyle(
                  color: AppColors.closeColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700)),
        ),
        body: ListView(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                imageUrl: product.image,
                fit: BoxFit.cover,
                progressIndicatorBuilder:
                    (_, __, DownloadProgress downloadProgress) => Center(
                        child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  valueColor: const AlwaysStoppedAnimation(Colors.deepOrange),
                )),
                errorWidget: (_, __, ___) => Image.asset(
                  'images/app_logo.png',
                  repeat: ImageRepeat.noRepeat,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w800,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '${double.parse(product.oldPrice).toStringAsFixed(2)}Kz',
                          style: const TextStyle(
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough,
                              color: Color(0xFFF00000),
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${product.basePrice.toStringAsFixed(2)}Kz',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                        'Quantidade mínima para o pedido ${product.minimumNumber}'),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Descrição',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                product.description.isEmpty
                    ? 'Sem descrição'
                    : product.description,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: product.description.isEmpty
                        ? Colors.red
                        : Colors.grey[700]),
                textAlign: TextAlign.justify,
              ),
            ),
            if (!product.isDisponible)
              const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    'Este produto não está mais disponível',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  )),
            Consumer2<UserManager, ProductModel>(
                builder: (_, userManager, product, __) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.all(16),
                    enableFeedback: true,
                    onSurface: Colors.grey,
                    backgroundColor: AppColors.closeColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                  ),
                  onPressed: product != null
                      ? () {
                          if (userManager.isLoggedIn) {
                            context.read<CartManager>().addToCart(product);
                            Flushbar(
                              icon: Icon(
                                FontAwesomeIcons.checkCircle,
                                color: AppColors.closeColor,
                              ),
                              title: 'Comprar',
                              titleColor: AppColors.closeColor,
                              duration: Duration(seconds: 2),
                              backgroundColor: AppColors.shopbackground,
                              messageColor: Colors.black,
                              messageText: Text(
                                '${product.name} comprado(a)',
                                style: TextStyle(
                                  color: AppColors.closeColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              flushbarPosition: FlushbarPosition.TOP,
                              isDismissible: true,
                            ).show(context);
                            //Get.to(() => CartScreen());
                          } else {
                            Get.to(() => LoginScreen());
                          }
                        }
                      : null,
                  child: !userManager.loading
                      ? Text(
                          userManager.isLoggedIn
                              ? 'Adicionar ao carrinho'
                              : 'Entre para comprar',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
