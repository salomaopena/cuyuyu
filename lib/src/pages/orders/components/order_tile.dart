//@dart=2.9
import 'package:cuyuyu/src/models/cart/cart_product.dart';
import 'package:cuyuyu/src/models/orders/order.dart';
import 'package:cuyuyu/src/pages/orders/components/cancel_order_dialog.dart';
import 'package:cuyuyu/src/pages/orders/components/export_address_dialog.dart';
import 'package:cuyuyu/src/pages/orders/components/order_prodcut_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({this.order, this.showControls = false});
  final Order order;
  final bool showControls;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.formattedId,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700, color: primaryColor),
                ),
                Text(
                  '${order.price.toStringAsFixed(2)}Kz',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Text(
              order.statusText,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  color: order.status == Status.canceled
                      ? Colors.red
                      : primaryColor),
            )
          ],
        ),
        children: [
          Column(
              children: order.items.map((CartProduct productCart) {
            return OrderProductTile(producCart: productCart);
          }).toList()),
          if (showControls && order.status != Status.canceled)
            SizedBox(
              height: 40,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => CancelOrderDialog(order: order));
                      },
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.red),
                      )),
                  TextButton(
                      onPressed: order.back,
                      child: const Text(
                        'Recuar',
                        style: TextStyle(color: Colors.black),
                      )),
                  TextButton(
                      onPressed: order.advance,
                      child: const Text(
                        'Avançar',
                        style: TextStyle(color: Colors.black),
                      )),
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) =>
                                ExportAddressDialog(address: order.address));
                      },
                      child: const Text(
                        'Endereço',
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ),
            ),
          const SizedBox(height: 4)
        ],
      ),
    );
  }
}
