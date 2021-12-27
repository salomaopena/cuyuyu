// @dart=2.9
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/models/page/page_manager.dart';
import 'package:cuyuyu/src/pages/about/about_screen.dart';
import 'package:cuyuyu/src/pages/admin_orders/admin_orders_screen.dart';
import 'package:cuyuyu/src/pages/admin_users/admin_users_screen.dart';
import 'package:cuyuyu/src/pages/call_center/call_center.dart';
import 'package:cuyuyu/src/pages/category/category_screen.dart';
import 'package:cuyuyu/src/pages/home/home_screen.dart';
import 'package:cuyuyu/src/pages/orders/orders_screen.dart';
import 'package:cuyuyu/src/pages/products/product_screen.dart';
import 'package:cuyuyu/src/pages/settings/settings_screen.dart';
import 'package:cuyuyu/src/pages/stores/store_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int currentIndex = 8;
  final PageController pageController = PageController();

  @override
  void initState() {
    configFCM();
    Permission.photos.request();
    Permission.location.request();
    Permission.storage.request();
    super.initState();
  }

  void configFCM() {
    final fcm = FirebaseMessaging.instance;
    if (Platform.isIOS) {
      fcm.requestPermission(
          alert: true,
          badge: true,
          provisional: true,
          sound: true,
          announcement: true,
          carPlay: true,
          criticalAlert: true);
    }
    fcm.setForegroundNotificationPresentationOptions(
        sound: true, badge: true, alert: true);

    //Old onLaunch and onResume
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      showNotification(message.notification.title, message.notification.body);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message.notification.title, message.notification.body);
    });
  }

  void showNotification(String title, String body) {
    Flushbar(
      title: title,
      message: body,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      isDismissible: true,
      backgroundColor: Theme.of(context).primaryColor,
      duration: const Duration(seconds: 5),
      icon: const Icon(Icons.shopping_basket, color: Colors.white),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<PageManager>(
        builder: (_, pageManager, __) {
          return Scaffold(
              body: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  HomeScreen(),
                  OrdersScreen(),
                  CallCenter(),
                  const StoreScreen(),
                  const CategoryScreen(),
                  const ProductScreen(),
                  SettingsScreen(),
                  AdminOrdersScreen(),
                  AdminUsersScreen(),
                  AboutScreen(),
                ],
              ),
              bottomNavigationBar: BottomNavyBar(
                selectedIndex: currentIndex,
                showElevation: false,
                backgroundColor: AppColors.nearlyWhite,
                onItemSelected: (index) => setState(() {
                  currentIndex = index;
                  pageManager.setPage(index);
                }),
                items: [
                  BottomNavyBarItem(
                    icon: const Icon(FontAwesomeIcons.home),
                    title: const Text('Home'),
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  BottomNavyBarItem(
                      icon: const Icon(FontAwesomeIcons.shoppingBag),
                      title: const Text('Pedidos'),
                      activeColor: Theme.of(context).primaryColor),
                  BottomNavyBarItem(
                      icon: const Icon(FontAwesomeIcons.headset),
                      title: const Text('Call Center'),
                      activeColor: Theme.of(context).primaryColor),
                  BottomNavyBarItem(
                      icon: const Icon(FontAwesomeIcons.storeAlt),
                      title: const Text('Lojas'),
                      activeColor: Theme.of(context).primaryColor),
                ],
              ));
        },
      ),
    );
  }
}
