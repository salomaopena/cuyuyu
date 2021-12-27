import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/models/orders/order.dart';
import 'package:cuyuyu/src/pages/orders/components/order_prodcut_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pedido confirmado',
          style: TextStyle(
              color: AppColors.closeColor,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          elevation: 0,
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.formattedId,
                      style:  GoogleFonts.roboto(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.deepOrange),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${order.price.toStringAsFixed(2)}Kz',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Column(
                  children: order.items.map((productCart) {
                return OrderProductTile(producCart: productCart);
              }).toList()),
            ],
          ),
        ),
      ),
    );
  }
}
