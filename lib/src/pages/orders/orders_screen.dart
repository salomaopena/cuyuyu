//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/common/empty_card.dart';
import 'package:cuyuyu/src/models/orders/orders_manager.dart';
import 'package:cuyuyu/src/pages/home/components/custom_drawer.dart';
import 'package:cuyuyu/src/pages/login/components/login_card.dart';
import 'package:cuyuyu/src/pages/orders/components/order_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text(
          'Meus Pedidos',
          style: TextStyle(
              color: AppColors.closeColor,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),

      ),
      body: Consumer<OrdersManager>(
        builder: (_, OrdersManager ordersManager,__) {
          if (ordersManager.user == null) {
            return const LoginCard();
          }

          if (ordersManager.orders.isEmpty) {
            return const EmptyCard(
              title: 'Nenhum pedido efectuado!',
              icon: Icons.hourglass_empty,
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: ordersManager.orders.length,
            separatorBuilder: (_, int index) => const SizedBox(height: 8),
            itemBuilder: (_, int index) {
              return OrderTile(
                  order:
                  ordersManager.orders.reversed.toList()[index]);
            },
          );
        }
      )
    );
  }

}
