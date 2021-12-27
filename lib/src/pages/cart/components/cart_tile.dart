// @dart=2.9

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/common/custom_icon_button.dart';
import 'package:cuyuyu/src/models/cart/cart_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  const CartTile({@required this.cartProduct});

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: CachedNetworkImage(
                  imageUrl: cartProduct.product.image,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.medium,
                  progressIndicatorBuilder:
                      (_, __, DownloadProgress downloadProgress) => Center(
                          child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    valueColor: const AlwaysStoppedAnimation(Colors.deepOrange),
                  )),
                  errorWidget: (_, __, ___) => const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 32,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartProduct.product.name,
                        style: GoogleFonts.roboto(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Quantidade mínima: ${cartProduct.product.minimumNumber}',
                          style: const TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                      Consumer<CartProduct>(builder: (_, cartProduct, __) {
                        return Text(
                          '${cartProduct.unityPrice.toStringAsFixed(2)}Kz',
                          style: GoogleFonts.roboto(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              Consumer<CartProduct>(
                builder: (_, cartProduct, __) {
                  return Column(
                    children: [
                      CustomIconButton(
                        icon: Icons.add,
                        color: Theme.of(context).primaryColor,
                        onTap: cartProduct.increment,
                      ),
                      Text('${cartProduct.quantity}'),
                      CustomIconButton(
                        icon: Icons.remove,
                        color: cartProduct.quantity > 1
                            ? Theme.of(context).primaryColor
                            : AppColors.redColor,
                        onTap: cartProduct.decrement,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
