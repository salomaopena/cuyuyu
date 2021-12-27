//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/models/stores/stores_manager.dart';
import 'package:cuyuyu/src/pages/home/components/custom_drawer.dart';
import 'package:cuyuyu/src/pages/home/components/search_dialog.dart';
import 'package:cuyuyu/src/pages/stores/components/shop_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Consumer<StoresManager>(
          builder: (_, storesManager, __) {
            if (storesManager.search.isEmpty) {
              return const Text(
                'Lojas',
                style: TextStyle(
                    color: AppColors.closeColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              );
            } else {
              return LayoutBuilder(builder: (_, constraints) {
                return GestureDetector(
                  onTap: () async {
                    final search = await showDialog<String>(
                        context: context,
                        builder: (_) => SearchDialog(storesManager.search));
                    if (search != null) {
                      storesManager.search = search;
                    }
                  },
                  child: SizedBox(
                      width: constraints.biggest.width,
                      child: Text(
                        storesManager.search,
                        textAlign: TextAlign.center,
                      )),
                );
              });
            }
          },
        ),
        actions: [
          Consumer<StoresManager>(builder: (_, storesManager, __) {
            if (storesManager.search.isEmpty) {
              return IconButton(
                icon: const Icon(
                  Icons.search,
                  color: AppColors.closeColor,
                ),
                onPressed: () async {
                  final search = await showDialog<String>(
                      context: context,
                      builder: (_) => SearchDialog(storesManager.search));
                  if (search != null) {
                    storesManager.search = search;
                  }
                },
              );
            } else {
              return IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.deepOrange,
                ),
                onPressed: () async {
                  storesManager.search = '';
                },
              );
            }
          }),
        ],
      ),
      body: Consumer<StoresManager>(
        builder: (_, storesManager, __) {
          final filteredStores = storesManager.filteredStored;
          if (filteredStores.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.orange),
                backgroundColor: Colors.transparent,
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: filteredStores.length,
            itemBuilder: (_, index) {
              return StoreCard(store: filteredStores[index]);
            },
            separatorBuilder: (_, index) => const SizedBox(height: 8),
          );
        },
      ),
    );
  }
}
