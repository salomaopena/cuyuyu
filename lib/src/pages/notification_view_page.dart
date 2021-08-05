import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/components/bottom_nav_bar.dart';
import 'package:cuyuyu/src/models/message_notification.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/enums.dart';
import 'package:flutter/material.dart';

class NotificationViewPage extends StatefulWidget {
  @override
  _NotificationViewPageState createState() => _NotificationViewPageState();
}

class _NotificationViewPageState extends State<NotificationViewPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final List<Message> messages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //Token dNiz1e90STKuViBvcYHLr1:APA91bErX82hk-enTfNwQGTNDbqpj_IH1Jbnp_bx_toRwgoAVqHLhM9kOZ-xasijebYlUhrcivwN_Eu9hxz0cxx1p3fIM4YV7MVZ_P5ODm66V1nRaKaOaC7DEBFzOZ4_rAf_8S_2Uo17

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
        children: [
          Expanded(
              child: ListView(
            children: messages.map(buildMessage).toList(),
          ))
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }

  Widget buildMessage(Message message) {
    return ListTile(
      title: Text(message.title),
      subtitle: Text(message.body),
    );
  }
}
