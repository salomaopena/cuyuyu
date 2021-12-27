// @dart=2.9

import 'package:cuyuyu/src/models/cart/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({this.textButton, this.onPressed});
  final String textButton;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final productPrice = cartManager.productsPrice;
    final deliveryPrice = cartManager.deliveryPrice;
    final totalPrice = cartManager.totalPrice;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Resumo do pedido',
              textAlign: TextAlign.start,
              style: GoogleFonts.roboto(
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style: GoogleFonts.roboto(),
                ),
                Text(
                  '${productPrice.toStringAsFixed(2)}Kz',
                  style: GoogleFonts.roboto(),
                )
              ],
            ),
            if (cartManager.deliveryPrice > 0.0) ...[
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Frete', style: GoogleFonts.roboto()),
                  Text(
                    '${deliveryPrice.toStringAsFixed(2)}Kz',
                    style: GoogleFonts.roboto(),
                  )
                ],
              ),
            ],
            const Divider(),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  '${totalPrice.toStringAsFixed(2)}Kz',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.all(16),
                  enableFeedback: true,
                  onSurface: Colors.grey,
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                onPressed: onPressed,
                child: Text(
                  textButton,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
