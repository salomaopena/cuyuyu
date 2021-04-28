import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/pages/chat_page.dart';
import 'package:cuyuyu/src/pages/faq_page.dart';
import 'package:cuyuyu/src/pages/notification_view_page.dart';
import 'package:cuyuyu/src/pages/privacy_policy.dart';
import 'package:cuyuyu/src/pages/tracking_page.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/colors.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'change_profile_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    return SafeArea(
      top: true,
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
                            child: Center(child: new LinearProgressIndicator()),
                          );

                        default:
                          if (snapshot.hasData) {
                            timestamp = snapshot.data.data()['created'];
                            return Container(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 16.0,
                                    right: 16.0,
                                    top: kToolbarHeight),
                                child: Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                      maxRadius: 48,
                                      backgroundColor: cuyuyuOrange100,
                                      backgroundImage: NetworkImage(
                                          snapshot.data.data()['photoUrl']),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 8.0, left: 8.0, right: 8.0),
                                      child: Text(
                                          snapshot.data.data()['userName'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                  color: cuyuyuOrange,
                                                  fontFamily: 'Raleway',
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          snapshot.data.data()['userMail'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                  color: AppTheme.grey,
                                                  fontFamily: 'Raleway',
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold)),
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
                                          color: cuyuyuSurfaceWhite,
                                          boxShadow: [
                                            BoxShadow(
                                                color: transparentYellow,
                                                blurRadius: 5,
                                                spreadRadius: 1,
                                                offset: Offset(0, 1))
                                          ]),
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
                                                            fontFamily:
                                                                'Raleway',
                                                            fontSize: 14.0)),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                    snapshot.data
                                                        .data()['gender'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .copyWith(
                                                            color:
                                                                AppTheme.grey,
                                                            fontFamily:
                                                                'Raleway',
                                                            fontSize: 14.0)),
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
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .copyWith(
                                                            color:
                                                                AppTheme.grey,
                                                            fontFamily:
                                                                'Raleway',
                                                            fontSize: 14.0)),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                    snapshot.data
                                                        .data()['phoneNumber'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .copyWith(
                                                            color:
                                                                AppTheme.grey,
                                                            fontFamily:
                                                                'Raleway',
                                                            fontSize: 14.0)),
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
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .copyWith(
                                                            color:
                                                                AppTheme.grey,
                                                            fontFamily:
                                                                'Raleway',
                                                            fontSize: 14.0)),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                    snapshot.data
                                                        .data()['address'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .copyWith(
                                                            color:
                                                                AppTheme.grey,
                                                            fontFamily:
                                                                'Raleway',
                                                            fontSize: 14.0)),
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
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .copyWith(
                                                            color:
                                                                AppTheme.grey,
                                                            fontFamily:
                                                                'Raleway',
                                                            fontSize: 14.0)),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                    timestamp
                                                        .toDate()
                                                        .toLocal()
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .copyWith(
                                                            color:
                                                                AppTheme.grey,
                                                            fontFamily:
                                                                'Raleway',
                                                            fontSize: 14.0)),
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
                                          color: cuyuyuSurfaceWhite,
                                          boxShadow: [
                                            BoxShadow(
                                                color: transparentYellow,
                                                blurRadius: 5,
                                                spreadRadius: 1,
                                                offset: Offset(0, 1))
                                          ]),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                IconButton(
                                                  icon: Badge(
                                                      badgeContent: Text(
                                                        '1',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2
                                                            .copyWith(
                                                              color:
                                                                  cuyuyuSurfaceWhite,
                                                              fontFamily:
                                                                  'Raleway',
                                                            ),
                                                      ),
                                                      child: Icon(Icons.person,
                                                          size: 30,
                                                          color: cuyuyuOrange)),
                                                  onPressed: () {
                                                    if(FirebaseAuth.instance.currentUser!=null){
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ChangeProfilePage()));
                                                    }else{
                                                      Toast.show("Sessão inválida! Inicie sessão e volte mais tarde.", context,duration: Toast.LENGTH_LONG,gravity: Toast.CENTER,);
                                                    }
                                                  },
                                                ),
                                                Text('Alterar perfil',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .copyWith(
                                                            fontFamily:
                                                                'Raleway')),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                IconButton(
                                                  icon: Icon(
                                                      Icons.airport_shuttle,
                                                      size: 30,
                                                      color: cuyuyuOrange),
                                                  onPressed: () => Navigator.of(
                                                          context)
                                                      .push(MaterialPageRoute(
                                                          builder: (context) =>
                                                              TrackingPage())),
                                                ),
                                                Text('Pedidos',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .copyWith(
                                                            fontFamily:
                                                                'Raleway')),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                IconButton(
                                                  icon: Icon(
                                                      Icons
                                                          .notifications_active,
                                                      size: 30,
                                                      color: cuyuyuOrange),
                                                  onPressed: () => Navigator.of(
                                                          context)
                                                      .push(MaterialPageRoute(
                                                          builder: (context) =>
                                                              NotificationViewPage())),
                                                ),
                                                Text('Notificações',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .copyWith(
                                                            fontFamily:
                                                                'Raleway')),
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
                                          color: cuyutyuBlue),
                                      trailing: Icon(Icons.chevron_right,
                                          color: cuyuyuOrgane300),
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) => PrivacyPage())),
                                    ),
                                    Divider(),
                                    ListTile(
                                      title: Text('Apoio & ajuda'),
                                      subtitle: Text(''),
                                      leading:
                                          Icon(Icons.help, color: cuyutyuBlue),
                                      trailing: Icon(
                                        Icons.chevron_right,
                                        color: cuyuyuOrgane300,
                                      ),
                                      onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => HelpPage(),
                                      )),
                                    ),
                                    Divider(),
                                    ListTile(
                                      title: Text('FAQ'),
                                      subtitle: Text('Perguntas frequêntes'),
                                      leading: Icon(Icons.hearing,
                                          color: cuyutyuBlue),
                                      trailing: Icon(Icons.chevron_right,
                                          color: cuyuyuOrgane300),
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) => FaqPage())),
                                    ),
                                    Divider(),
                                  ],
                                ),
                              ),
                            );
                          }
                      }
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
                        backgroundColor: cuyuyuOrange100,
                        backgroundImage: AssetImage('images/app_logo.png'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Cuyuyu Entregas',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    color: cuyuyuOrange,
                                    fontFamily: 'Raleway',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
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
                            color: cuyuyuSurfaceWhite,
                            boxShadow: [
                              BoxShadow(
                                  color: transparentYellow,
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  offset: Offset(0, 1))
                            ]),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon: Badge(
                                        badgeContent: Text(
                                          '1',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                color: cuyuyuSurfaceWhite,
                                                fontFamily: 'Raleway',
                                              ),
                                        ),
                                        child: Icon(Icons.person,
                                            size: 30, color: cuyuyuOrange)),
                                    onPressed: () {
                                      if(FirebaseAuth.instance.currentUser!=null){
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChangeProfilePage()));
                                      }else{
                                        Toast.show("Sessão inválida! Inicie sessão e volte mais tarde.", context,duration: Toast.LENGTH_LONG,gravity: Toast.CENTER,);
                                      }
                                    },
                                  ),
                                  Text('Alterar perfil',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(fontFamily: 'Raleway')),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.airport_shuttle,
                                        size: 30, color: cuyuyuOrange),
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TrackingPage())),
                                  ),
                                  Text('Pedidos',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(fontFamily: 'Raleway')),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.notifications_active,
                                        size: 30, color: cuyuyuOrange),
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NotificationViewPage())),
                                  ),
                                  Text('Notificações',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(fontFamily: 'Raleway')),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('Definições'),
                        subtitle: Text('Privacidade'),
                        leading: Icon(Icons.settings, color: AppTheme.cuyutyuBlue),
                        trailing:
                            Icon(Icons.chevron_right, color: cuyuyuOrgane300),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => PrivacyPage())),
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Apoio & ajuda'),
                        subtitle: Text(''),
                        leading: Icon(Icons.help, color: AppTheme.cuyutyuBlue),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: cuyuyuOrgane300,
                        ),
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HelpPage(),
                        )),
                      ),
                      Divider(),
                      ListTile(
                        title: Text('FAQ'),
                        subtitle: Text('Perguntas frequêntes'),
                        leading: Icon(Icons.hearing, color: AppTheme.cuyutyuBlue),
                        trailing:
                            Icon(Icons.chevron_right, color: cuyuyuOrgane300),
                        onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => FaqPage())),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Future<DocumentSnapshot> loadUser() {
    return userReference.doc(auth.currentUser.uid).get();
  }
}
