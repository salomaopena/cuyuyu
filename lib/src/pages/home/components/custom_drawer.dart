//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/models/page/page_manager.dart';
import 'package:cuyuyu/src/models/users/user_manager.dart';
import 'package:cuyuyu/src/pages/home/components/drawer_tile.dart';
import 'package:cuyuyu/src/pages/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<UserManager>(
            builder: (_, UserManager userManager, __) {
              return UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: AppColors.white),
                accountName: Text(
                  userManager.user != null
                      ? 'Olá, ${userManager.user?.userName}'
                      : 'Olá, Anónimo',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.closeColor),
                ),
                accountEmail: Text(
                    userManager.isLoggedIn
                        ? 'Terminar sessão'
                        : 'Entrar ou Cadastrar-se',
                    style: TextStyle(
                        color: userManager.isLoggedIn
                            ? AppColors.redColor
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16)),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: AppColors.chipBackground,
                  child: userManager.user != null
                      ? Text(userManager.user.userName.substring(0, 1),
                          style: const TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.w800,
                              color: AppColors.closeColor))
                      : const Text(
                          'A',
                          style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.w800,
                              color: AppColors.closeColor),
                        ),
                ),
                arrowColor: AppColors.closeColor,
                onDetailsPressed: () {
                  if (userManager.isLoggedIn) {
                    context.read<PageManager>().setPage(0);
                    userManager.signOut();
                  } else {
                    Get.back(canPop: true);
                    Get.to(() => LoginScreen());
                  }
                },
              );
            },
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                const DrawerTile(
                  iconData: FontAwesomeIcons.home,
                  title: "Início",
                  page: 0,
                ),
                const DrawerTile(
                  iconData: FontAwesomeIcons.shoppingBag,
                  title: "Meus Pedidos",
                  page: 1,
                ),
                const DrawerTile(
                  iconData: FontAwesomeIcons.headset,
                  title: "Call Center",
                  page: 2,
                ),
                const DrawerTile(
                  iconData: FontAwesomeIcons.storeAlt,
                  title: "Lojas",
                  page: 3,
                ),
                const DrawerTile(
                  iconData: FontAwesomeIcons.capsules,
                  title: "Categorias",
                  page: 4,
                ),
                const DrawerTile(
                  iconData: FontAwesomeIcons.clipboardList,
                  title: "Produtos",
                  page: 5,
                ),
                const DrawerTile(
                  iconData: FontAwesomeIcons.cog,
                  title: "Definições",
                  page: 6,
                ),
                Consumer<UserManager>(builder: (_, userManager, __) {
                  if (userManager.adminEnabled) {
                    return Column(
                      children: const [
                        Divider(indent: 20),
                        DrawerTile(
                          iconData: Icons.featured_play_list,
                          title: "Todos Pedidos",
                          page: 7,
                        ),
                        DrawerTile(
                          iconData: Icons.group,
                          title: "Utilizadores",
                          page: 8,
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),
                const DrawerTile(
                  iconData: Icons.book,
                  title: 'Sobre',
                  page: 9,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
