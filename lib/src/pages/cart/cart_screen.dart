//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/common/empty_card.dart';
import 'package:cuyuyu/src/common/price_card.dart';
import 'package:cuyuyu/src/models/cart/cart_manager.dart';
import 'package:cuyuyu/src/pages/address/address_screen.dart';
import 'package:cuyuyu/src/pages/cart/components/cart_tile.dart';
import 'package:cuyuyu/src/pages/login/components/login_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carinho de compras',
            style: TextStyle(
                color: AppColors.closeColor,
                fontSize: 18,
                fontWeight: FontWeight.w700)),
      ),
      body: Consumer<CartManager>(
        builder: (_, cartManager, __) {
          if (cartManager.user == null) {
            return const LoginCard();
          }
          if(cartManager.items.isEmpty){
            return const EmptyCard(
              icon: Icons.remove_shopping_cart,
              title: 'Nenhum produto adicionado no carrinho',
            );
          }
          return ListView(
            children: [
              Column(
                children: cartManager.items
                    .map((cartProduct) => CartTile(cartProduct: cartProduct))
                    .toList(),
              ),
              PriceCard(
                textButton: 'Continuar para a entrega',
                onPressed: (){
                  Get.to(()=>const AddressScreen());
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
