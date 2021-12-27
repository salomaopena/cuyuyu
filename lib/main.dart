// @dart=2.9

import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/models/banners/banner_manager.dart';
import 'package:cuyuyu/src/models/cart/cart_manager.dart';
import 'package:cuyuyu/src/models/category/category_manager.dart';
import 'package:cuyuyu/src/models/notification/notifications_manager.dart';
import 'package:cuyuyu/src/models/orders/admin_orders_manager.dart';
import 'package:cuyuyu/src/models/orders/orders_manager.dart';
import 'package:cuyuyu/src/models/products/product_manager.dart';
import 'package:cuyuyu/src/models/stores/stores_manager.dart';
import 'package:cuyuyu/src/models/users/admin_users_manager.dart';
import 'package:cuyuyu/src/models/users/user_manager.dart';
import 'package:cuyuyu/src/pages/base/base_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => StoresManager(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (_) => BannerManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, NotificationsManager>(
          create: (_) => NotificationsManager(),
          lazy: false,
          update: (_, userManager, chatManager) =>
              chatManager..updateUser(userManager.user),
        ),
        /*ChangeNotifierProxyProvider<UserManager, ChatManager>(
          create: (_) => ChatManager(),
          lazy: false,
          update: (_, userManager, chatManager) =>
              chatManager..updateUser(userManager.user),
        ),*/
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, UserManager userManager, CartManager cartManager) =>
              cartManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, OrdersManager>(
          create: (_) => OrdersManager(),
          lazy: false,
          update: (_, UserManager userManager, OrdersManager ordersManager) =>
              ordersManager..updateUser(userManager.user),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminOrdersManager>(
            create: (_) => AdminOrdersManager(),
            lazy: false,
            update: (_, userManager, adminOrdersManager) => adminOrdersManager
              ..updateAdmin(adminEnabled: userManager.adminEnabled)),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
            create: (_) => AdminUsersManager(),
            lazy: false,
            update: (_, UserManager userManager,
                    AdminUsersManager adminUserManager) =>
                adminUserManager..updateUser(userManager))
      ],
      child: GetMaterialApp(
        enableLog: true,
        defaultTransition: Transition.fade,
        opaqueRoute: Get.isOpaqueRouteDefault,
        popGesture: Get.isPopGestureEnable,
        transitionDuration: Get.defaultDialogTransitionDuration,
        title: 'Cuyuyu Entregas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          dividerColor: const Color(0xFFECEDF1),
          backgroundColor: AppColors.shopbackground,
          splashColor: Colors.black,
          scaffoldBackgroundColor: AppColors.shopbackground,
          primaryColor: const Color(0xFFFF7643),
          fontFamily: 'Metropolis',
          appBarTheme: const AppBarTheme(
            color: AppColors.nearlyWhite,
            centerTitle: true,
            actionsIconTheme: IconThemeData.fallback(),
            iconTheme: IconThemeData(color: AppColors.closeColor),
            elevation: 0,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            subtitle2: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            subtitle1: TextStyle(fontSize: 16),
            bodyText1: TextStyle(fontSize: 14.0, fontFamily: 'Metropolis'),
            caption: TextStyle(
                fontSize: 14.0, fontFamily: 'Metropolis', color: Colors.white),
            headline2: TextStyle(
                fontSize: 14.0,
                fontFamily: 'Metropolis',
                color: Colors.black54),
          ),
        ),
        home: BaseScreen(),
      ),
    );
  }
}
