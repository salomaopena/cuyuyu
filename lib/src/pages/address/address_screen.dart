import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/common/price_card.dart';
import 'package:cuyuyu/src/models/cart/cart_manager.dart';
import 'package:cuyuyu/src/pages/checkout/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'components/address_card.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'Endereço de entrega',
          style: TextStyle(
              color: AppColors.closeColor,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        )
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            const AddressCard(),
            Consumer<CartManager>(builder: (_, cartManager, __) {
              return PriceCard(
                textButton: 'Continuar para o pagamento',
                onPressed: cartManager.isAddressValid ?() {
                  Get.to(()=>CheckoutScreen());
                }: null,
              );
            })
          ],
        ),
      ),
    );
  }
}
