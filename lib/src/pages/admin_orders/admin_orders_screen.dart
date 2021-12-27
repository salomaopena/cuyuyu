//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/common/custom_icon_button.dart';
import 'package:cuyuyu/src/common/empty_card.dart';
import 'package:cuyuyu/src/models/orders/admin_orders_manager.dart';
import 'package:cuyuyu/src/models/orders/order.dart';
import 'package:cuyuyu/src/pages/home/components/custom_drawer.dart';
import 'package:cuyuyu/src/pages/orders/components/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AdminOrdersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text(
          'Todos Pedidos',
          style: TextStyle(
              color: AppColors.closeColor,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomIconButton(
                icon: Icons.sort,
                color: Colors.deepOrange,
                onTap: () {
                  Alert(
                    context: context,
                    type: AlertType.none,
                    title: 'Filtros',
                    content:Consumer<AdminOrdersManager>(
                        builder: (_, AdminOrdersManager adminOrdersManager, __) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: Status.values.map((status) {
                              return CheckboxListTile(
                                title: Text(Order.getStatusText(status)),
                                dense: true,
                                activeColor: Theme.of(context).primaryColor,
                                value: adminOrdersManager.statusFiltered.contains(status),
                                onChanged: (value) {
                                  adminOrdersManager.setStatusFilter(
                                      status: status, enabled: value);
                                },
                              );
                            }).toList(),
                          );
                        }
                    ) ,
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Ok",
                          style: GoogleFonts.roboto(color: Colors.white, fontSize: 17),
                        ),
                        onPressed: () => Get.back(canPop: true),
                        color: Colors.deepOrange,
                      )
                    ],
                  ).show();
                }),
          )
        ],
      ),
      body: Consumer<AdminOrdersManager>(
          builder: (_, AdminOrdersManager adminOrdersManager, __) {
        final filteredOrders = adminOrdersManager.filteredOrders;
        return Column(
          children: [
            if (adminOrdersManager.userFilter != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                          'Pedidos de ${adminOrdersManager.userFilter.userName}',
                          style: const TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.w800),
                        )),
                    CustomIconButton(
                        icon: Icons.close,
                        color: Colors.deepOrange,
                        onTap: () {
                          adminOrdersManager.setUserFilter(null);
                        })
                  ],
                ),
              ),
            if (filteredOrders.isEmpty)
              const Expanded(
                child: EmptyCard(
                  title: 'Nenhuma compra encontrada',
                  icon: Icons.border_clear,
                ),
              )
            else
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: filteredOrders.length,
                  separatorBuilder: (_, int index) =>
                  const SizedBox(height: 8),
                  itemBuilder: (_, int index) {
                    return OrderTile(
                        order: filteredOrders[index], showControls: true);
                  },
                ),
              ),
          ],
        );
      }),
    );
  }
}
