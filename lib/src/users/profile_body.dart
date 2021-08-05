//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/pages/about_page.dart';
import 'package:cuyuyu/src/pages/chat_page.dart';
import 'package:cuyuyu/src/pages/faq_page.dart';
import 'package:cuyuyu/src/pages/home/home_screen.dart';
import 'package:cuyuyu/src/pages/notification_view_page.dart';
import 'package:cuyuyu/src/pages/settings_page.dart';
import 'package:cuyuyu/src/pages/support_page.dart';
import 'package:cuyuyu/src/pages/tracking_page.dart';
import 'package:cuyuyu/src/users/login_page.dart';
import 'package:cuyuyu/src/utils/IconBtnWithCounter.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'change_profile_page.dart';

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  final user = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference userReference;
  Timestamp timestamp;

  @override
  void initState() {
    // TODO: implement initState
    userReference = user.collection(USER_URL);
    if (auth.currentUser != null) {
      loadUser();
    }
    FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: FirebaseAuth.instance.currentUser != null
            ? Container(
                child: FutureBuilder<DocumentSnapshot>(
                    future: loadUser(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Container(
                            child: Center(
                                child: new Text(
                                    'Internet fraca. \nPor favar, verifique a sua conexão.')),
                          );
                        case ConnectionState.waiting:
                          return Container(
                            child:
                                Center(child: new CircularProgressIndicator()),
                          );
                        default:
                          if (snapshot.hasData) {
                            timestamp = snapshot.data.data()['created'];
                            return Container(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: getProportionateScreenWidth(16.0),
                                    right: getProportionateScreenWidth(16.0)),
                                child: Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                      maxRadius: 48,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: NetworkImage(
                                          snapshot.data.data()['photoUrl']),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 8.0, left: 8.0, right: 8.0),
                                      child: Text(
                                          snapshot.data.data()['userName'],
                                          style: AppTheme.subtitle),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          snapshot.data.data()['userMail'],
                                          style: AppTheme.display4),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 16.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          topRight: Radius.circular(8.0),
                                          bottomLeft: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0),
                                        ),
                                        color: AppTheme.cuyuyuSurfaceWhite,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text('Sexo:',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .copyWith(
                                                            color:
                                                                AppTheme.grey,
                                                            fontFamily: 'Muli',
                                                            fontSize: 14.0)),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                    snapshot.data
                                                        .data()['gender'],
                                                    style: AppTheme.display4),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text('Telefone:',
                                                    style: AppTheme.display4),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                    snapshot.data
                                                        .data()['phoneNumber'],
                                                    style: AppTheme.display4),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text('Morada:',
                                                    style: AppTheme.display4),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                    snapshot.data
                                                        .data()['address'],
                                                    style: AppTheme.display4),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text('Criado em:',
                                                    style: AppTheme.display4),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                    timestamp
                                                        .toDate()
                                                        .toLocal()
                                                        .toString(),
                                                    style: AppTheme.display4),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 150,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 16.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          topRight: Radius.circular(8.0),
                                          bottomLeft: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0),
                                        ),
                                        color: AppTheme.cuyuyuSurfaceWhite,
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                IconBtnWithCounter(
                                                  numOfitem: 1,
                                                  icon: Icon(
                                                    Icons.person,
                                                    color:
                                                        AppTheme.cuyuyuOrange,
                                                    size: 30,
                                                  ),
                                                  press: () {
                                                    if (FirebaseAuth.instance
                                                            .currentUser !=
                                                        null) {
                                                      Get.to(() =>
                                                          ChangeProfilePage());
                                                    } else {
                                                      Get.to(() => LoginPage());
                                                    }
                                                  },
                                                ),
                                                Text('Alterar perfil',
                                                    style: AppTheme.display4),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                IconBtnWithCounter(
                                                  icon: Icon(
                                                      Icons.airport_shuttle,
                                                      size: 30,
                                                      color: AppTheme
                                                          .cuyuyuOrange),
                                                  press: () => Get.to(
                                                      () => TrackingPage()),
                                                ),
                                                Text('Pedidos',
                                                    style: AppTheme.display4),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                IconBtnWithCounter(
                                                  numOfitem: 2,
                                                  icon: Icon(
                                                      Icons
                                                          .notifications_active,
                                                      size: 30,
                                                      color: AppTheme
                                                          .cuyuyuOrange),
                                                  press: () => Get.to(() =>
                                                      NotificationViewPage()),
                                                ),
                                                Text('Notificações',
                                                    style: AppTheme.display4),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('Definições'),
                                      subtitle: Text('Privacidade'),
                                      leading: Icon(Icons.settings,
                                          color: AppTheme.cuyutyuBlue),
                                      trailing: Icon(Icons.chevron_right,
                                          color: AppTheme.cuyuyuOrange300),
                                      onTap: () => Get.to(() => SettingsPage()),
                                    ),
                                    Divider(),
                                    ListTile(
                                      title: Text('Apoio & ajuda'),
                                      subtitle: Text('Nosso chat'),
                                      leading: Icon(Icons.help,
                                          color: AppTheme.cuyutyuBlue),
                                      trailing: Icon(
                                        Icons.chevron_right,
                                        color: AppTheme.cuyuyuOrange300,
                                      ),
                                      onTap: () => Get.to(
                                        () => SupportPage(),
                                      ),
                                    ),
                                    Divider(),
                                    ListTile(
                                      title: Text('FAQ'),
                                      subtitle: Text('Perguntas frequêntes'),
                                      leading: Icon(Icons.hearing,
                                          color: AppTheme.cuyutyuBlue),
                                      trailing: Icon(Icons.chevron_right,
                                          color: AppTheme.cuyuyuOrange300),
                                      onTap: () => Get.to(() => FaqPage()),
                                    ),
                                    Divider(),
                                    ListTile(
                                      title: Text('Sobre Nós'),
                                      subtitle: Text('O que deseja saber?'),
                                      leading: Icon(Icons.contact_mail_outlined,
                                          color: AppTheme.cuyutyuBlue),
                                      trailing: Icon(Icons.chevron_right,
                                          color: AppTheme.cuyuyuOrange300),
                                      onTap: () => Get.to(() => AboutPage()),
                                    ),
                                    Divider(),
                                    auth.currentUser == null
                                        ? ListTile(
                                            title: Text(
                                              'Iniciar sessão',
                                            ),
                                            subtitle:
                                                Text("Inicie a sessão aqui..."),
                                            leading: Icon(
                                              Icons.power_settings_new,
                                              color: Colors.green,
                                            ),
                                            trailing: Icon(
                                              Icons.chevron_right,
                                              color: Colors.green,
                                            ),
                                            onTap: () {
                                              Get.to(
                                                () => LoginPage(),
                                              );
                                            },
                                          )
                                        : ListTile(
                                            title: Text('Terminar sessão'),
                                            subtitle: Text(
                                                "Deseja teminar a sessão?"),
                                            leading: Icon(
                                                Icons.power_settings_new,
                                                color: Colors.red),
                                            trailing: Icon(
                                              Icons.chevron_right,
                                              color: Colors.red,
                                            ),
                                            onTap: () {
                                              _showExitDialog(context);
                                            },
                                          ),
                                    Divider(),
                                  ],
                                ),
                              ),
                            );
                          }
                      }
                      return Container();
                    }),
              )
            : Container(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 16.0, right: 16.0, top: kToolbarHeight),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        maxRadius: 48,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage('images/app_logo.png'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Cuyuyu Entregas', style: AppTheme.title),
                      ),
                      Container(
                        height: 150,
                        margin: EdgeInsets.symmetric(vertical: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                          ),
                          color: AppTheme.cuyuyuSurfaceWhite,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconBtnWithCounter(
                                    numOfitem: 1,
                                    icon: Icon(Icons.person,
                                        size: 30, color: AppTheme.cuyuyuOrange),
                                    press: () {
                                      if (FirebaseAuth.instance.currentUser !=
                                          null) {
                                        Get.to(() => ChangeProfilePage());
                                      } else {
                                        Get.to(() => LoginPage());
                                      }
                                    },
                                  ),
                                  Text('Alterar perfil',
                                      style: AppTheme.display4),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconBtnWithCounter(
                                    numOfitem: 0,
                                    icon: Icon(Icons.airport_shuttle,
                                        size: 30, color: AppTheme.cuyuyuOrange),
                                    press: () => Get.to(() => TrackingPage()),
                                  ),
                                  Text('Pedidos', style: AppTheme.display4),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconBtnWithCounter(
                                    numOfitem: 2,
                                    icon: Icon(Icons.notifications_active,
                                        size: 30, color: AppTheme.cuyuyuOrange),
                                    press: () =>
                                        Get.to(() => NotificationViewPage()),
                                  ),
                                  Text('Notificações',
                                      style: AppTheme.display4),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('Definições'),
                        subtitle: Text('Privacidade'),
                        leading:
                            Icon(Icons.settings, color: AppTheme.cuyutyuBlue),
                        trailing: Icon(Icons.chevron_right,
                            color: AppTheme.cuyuyuOrange300),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => SettingsPage())),
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Apoio & ajuda'),
                        subtitle: Text('Nosso chat'),
                        leading: Icon(Icons.help, color: AppTheme.cuyutyuBlue),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: AppTheme.cuyuyuOrange300,
                        ),
                        onTap: () => Get.to(
                          () => HelpPage(),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        title: Text('FAQ'),
                        subtitle: Text('Perguntas frequêntes'),
                        leading:
                            Icon(Icons.hearing, color: AppTheme.cuyutyuBlue),
                        trailing: Icon(Icons.chevron_right,
                            color: AppTheme.cuyuyuOrange300),
                        onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => FaqPage())),
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Sobre Nós'),
                        subtitle: Text('O que deseja saber?'),
                        leading: Icon(Icons.contact_mail_outlined,
                            color: AppTheme.cuyutyuBlue),
                        trailing: Icon(Icons.chevron_right,
                            color: AppTheme.cuyuyuOrange300),
                        onTap: () => Get.to( () => AboutPage()),
                      ),
                      Divider(),
                      auth.currentUser == null
                          ? ListTile(
                              title: Text(
                                'Iniciar sessão',
                              ),
                              subtitle: Text("Inicie a sessão aqui..."),
                              leading: Icon(
                                Icons.power_settings_new,
                                color: Colors.green,
                              ),
                              trailing: Icon(
                                Icons.chevron_right,
                                color: Colors.green,
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ));
                              },
                            )
                          : ListTile(
                              title: Text('Terminar sessão'),
                              subtitle: Text("Deseja teminar a sessão?"),
                              leading: Icon(Icons.power_settings_new,
                                  color: Colors.red),
                              trailing: Icon(
                                Icons.chevron_right,
                                color: Colors.red,
                              ),
                              onTap: () {
                                _showExitDialog(context);
                              },
                            ),
                      Divider(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text(
        "Não",
        style:
            AppTheme.display4.copyWith(color: AppTheme.dismissibleBackground),
      ),
      onPressed: () {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ), (route) => false);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Sim", style: AppTheme.display4.copyWith(color: Colors.red)),
      onPressed: () {
        signOut(context: context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Terminar Sessão", style: AppTheme.display6),
      content: Text(
        "Deseja realmente terminar sessão?",
        style: AppTheme.display4,
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<void> signOut({BuildContext context}) async {
    try {
      if (!kIsWeb) {
        await GoogleSignIn().signOut().then((value) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              return HomeScreen();
            },
          ), (route) => false);
        });
      }
      await FirebaseAuth.instance.signOut().then((value) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ), (route) => false);
      });
    } catch (e) {
      print("Error: " + e);
    }
  }

  Future<DocumentSnapshot> loadUser() {
    return userReference.doc(auth.currentUser.uid).get();
  }
}
