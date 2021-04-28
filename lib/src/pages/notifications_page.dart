import 'dart:io';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
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
    return Container(
      color: ShopAppTheme.buildLightTheme().backgroundColor,
      child: SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getAppBarUI(),
              Flexible(
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
                  ],
                ),
              ),
            ],
          ),

          /*(
            child: Padding(
              padding: EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),

            ),
          ),*/
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: ShopAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.0),
              offset: const Offset(0, 0),
              blurRadius: 0.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Definições',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    fontFamily: 'Raleway',
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }
}
