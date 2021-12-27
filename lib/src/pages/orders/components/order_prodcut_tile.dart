//@dart=2.9
import 'package:cuyuyu/src/models/cart/cart_product.dart';
import 'package:cuyuyu/src/pages/product_details/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderProductTile extends StatelessWidget {
  const OrderProductTile({this.producCart});

  final CartProduct producCart;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(ProductDetailScreen(product: producCart.product)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: Image.network(producCart.product.image,
                  fit: BoxFit.fill),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    producCart.product.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      'Quantidade mínima: ${producCart.product.minimumNumber}',
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ),
                  Text(
                    '${(producCart.fixedPrice ?? producCart.unityPrice).toStringAsFixed(2)}Kz',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
            Text(
              '${producCart.quantity}x',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
