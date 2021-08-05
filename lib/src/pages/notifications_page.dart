import 'dart:io';
import 'package:cuyuyu/src/components/bottom_nav_bar.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool myOrders = true;
  bool reminders = true;
  bool newOffers = true;
  bool feedbackReviews = true;
  bool updates = true;

  Widget platformSwitch(bool val) {
    if (Platform.isIOS) {
      return CupertinoSwitch(
        onChanged: (value) {
          setState(() {
            val = value;
          });
        },
        value: true,
        activeColor:AppTheme.cuyuyuOrange400,
      );
    } else {
      return Switch(
        onChanged: (value) {
          setState(() {
            val = value;
          });
        },
        value: true,
        activeColor: AppTheme.cuyuyuOrange400,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notificações", style: AppTheme.title),
        elevation: 0,
        iconTheme: IconThemeData.fallback(),
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.nearlyBlack,
      ),
      backgroundColor: AppTheme.nearlyWhite,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                child: ListView(
                  padding: EdgeInsets.only(top: 24.0, left: 8.0, right: 8.0),
                  children: <Widget>[
                    ListTile(
                      title: Text('Meus pedidos'),
                      trailing: platformSwitch(myOrders),
                    ),
                    Divider(
                      endIndent: 80,
                    ),
                    ListTile(
                      title: Text('Lembretes'),
                      trailing: platformSwitch(reminders),
                    ),
                    Divider(
                      endIndent: 80,
                    ),
                    ListTile(
                      title: Text('Ofertas'),
                      trailing: platformSwitch(newOffers),
                    ),
                    Divider(
                      endIndent: 80,
                    ),
                    ListTile(
                      title: Text('Actualizações'),
                      trailing: platformSwitch(updates),
                    ),
                    Divider(
                      endIndent: 80,
                    ),
                    ListTile(
                      title: Text('Outras'),
                      trailing: platformSwitch(feedbackReviews),
                    ),
                    Divider(
                      endIndent: 80,
                    ),
                  ],
                ),
              ),
            ],
          ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
