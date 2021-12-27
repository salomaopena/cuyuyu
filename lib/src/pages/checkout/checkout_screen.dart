//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/common/price_card.dart';
import 'package:cuyuyu/src/models/cart/cart_manager.dart';
import 'package:cuyuyu/src/models/checkout/checkout_manager.dart';
import 'package:cuyuyu/src/models/orders/order.dart';
import 'package:cuyuyu/src/pages/base/base_screen.dart';
import 'package:cuyuyu/src/pages/cart/cart_screen.dart';
import 'package:cuyuyu/src/pages/checkout/components/payment_card.dart';
import 'package:cuyuyu/src/pages/confirmation/confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      lazy: false,
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) =>
          checkoutManager as CheckoutManager
            ..updateCart(cartManager as CartManager),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Pagamento',
            style: TextStyle(
                color: AppColors.closeColor,
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
        ),
        body: Consumer<CheckoutManager>(
            builder: (_, CheckoutManager checkoutManager, __) {
          if (checkoutManager.loading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.deepOrange),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'A procesar pagamento...',
                    style: TextStyle(
                      color: AppColors.closeColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                const PaymentCard(),
                PriceCard(
                  textButton: 'Finalizar pedido',
                  onPressed: () {
                    checkoutManager.checkout(onStockFail: (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Informação: $e'),
                        backgroundColor: AppColors.redColor,
                      ));
                      Get.off(() => CartScreen());
                    }, onSuccess: (Order order) {
                      Get.offAll(() => BaseScreen());
                      Get.to(() => ConfirmationScreen(order: order));
                    });
                  },
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
