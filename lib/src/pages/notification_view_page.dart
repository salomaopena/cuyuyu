import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/models/message_notification.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationViewPage extends StatefulWidget {
  @override
  _NotificationViewPageState createState() => _NotificationViewPageState();
}

class _NotificationViewPageState extends State<NotificationViewPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseMessaging messaging = FirebaseMessaging();
  final List<Message> messages = List();

  @override
  void initState() {
    // TODO: implement initState
    messaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
            title: notification['title'],
            body: notification['body'],
          ));
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        /*Toast.show(("onResume :$message"), context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);*/
      },
    );
    messaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, alert: true, badge: true));

    messaging.subscribeToTopic('Orders');
    /*messaging.getToken().then((token) {
      print("Token impressso: " + token);
      Toast.show(token, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    });*/
    super.initState();
  }

  //Token dNiz1e90STKuViBvcYHLr1:APA91bErX82hk-enTfNwQGTNDbqpj_IH1Jbnp_bx_toRwgoAVqHLhM9kOZ-xasijebYlUhrcivwN_Eu9hxz0cxx1p3fIM4YV7MVZ_P5ODm66V1nRaKaOaC7DEBFzOZ4_rAf_8S_2Uo17

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
            children: [
              getAppBarUI(),
              Expanded(
                  child: ListView(
                children: messages.map(buildMessage).toList(),
              )

                  /*SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [],
                  ),
                ),*/
                  )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMessage(Message message) {
    return ListTile(
      title: Text(message.title),
      subtitle: Text(message.body),
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
                  'Notificações',
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
