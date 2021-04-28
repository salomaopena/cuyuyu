import 'package:cuyuyu/src/custom_drawer/navigation_home_screen.dart';
import 'package:cuyuyu/src/pages/privacy_policy.dart';
import 'package:cuyuyu/src/pages/terms_and_conditions.dart';
import 'package:cuyuyu/src/users/change_password.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/custom_background.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'chat_page.dart';
import 'faq_page.dart';
import 'notifications_page.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Widget build(BuildContext context) {
    return Container(
      color: ShopAppTheme.buildLightTheme().backgroundColor,
      child: SafeArea(
        bottom: true,
        child: CustomPaint(
          painter: MainBackground(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 40.0, left: 24.0, right: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0, top: 80.0),
                          child: Text(
                            'Geral',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    color:AppTheme.cuyuyuOrange,
                                    fontFamily: 'Raleway',
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Notificações',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    color: AppTheme.cuyutyuBlue, fontFamily: 'Raleway'),
                          ),
                          leading: Icon(
                            Icons.notifications_active,
                            color: AppTheme.cuyuyuLigthBlue,
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NotificationPage()));
                          },
                        ),
                        ListTile(
                          title: Text(
                            'Termos de uso',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    color: AppTheme.cuyutyuBlue, fontFamily: 'Raleway'),
                          ),
                          leading: Icon(
                            Icons.list,
                            color:AppTheme. cuyuyuLigthBlue,
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TermsPage()));
                          },
                        ),
                        ListTile(
                          title: Text(
                            'Privacidade',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    color: AppTheme.cuyutyuBlue, fontFamily: 'Raleway'),
                          ),
                          leading: Icon(
                            Icons.security,
                            color: AppTheme.cuyuyuLigthBlue,
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PrivacyPage()));
                          },
                        ),
                        ListTile(
                          title: Text(
                            'Ajuda',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    color: AppTheme.cuyutyuBlue, fontFamily: 'Raleway'),
                          ),
                          leading: Icon(
                            Icons.help,
                            color: AppTheme.cuyuyuLigthBlue,
                          ),
                          onTap: () {
                            if (FirebaseAuth.instance.currentUser != null) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HelpPage()));
                            } else {
                              Toast.show(
                                  "Inicie sessão para ter acesso ao chat",
                                  context,
                                  gravity: Toast.CENTER,
                                  duration: Toast.LENGTH_LONG);
                            }
                          },
                        ),
                        ListTile(
                          title: Text(
                            'FAQ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    color: AppTheme.cuyutyuBlue, fontFamily: 'Raleway'),
                          ),
                          leading: Icon(
                            Icons.hearing,
                            color: AppTheme.cuyuyuLigthBlue,
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => FaqPage()));
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                          child: Text(
                            'Conta',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    color: AppTheme.cuyuyuOrange,
                                    fontFamily: 'Raleway',
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Alterar Senha',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    color: AppTheme.cuyutyuBlue, fontFamily: 'Raleway'),
                          ),
                          leading: Icon(
                            Icons.person,
                            color: AppTheme.cuyuyuLigthBlue,
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChangePasswordPage()));
                          },
                        ),
                        ListTile(
                          title: Text(
                            'Terminar sessão',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    color: AppTheme.cuyutyuBlue, fontFamily: 'Raleway'),
                          ),
                          leading: Icon(
                            Icons.power_settings_new,
                            color: Colors.red,
                          ),
                          onTap: () {
                            _showExitDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
        style: AppTheme.textTheme.bodyText1.copyWith(
            color: AppTheme.dismissibleBackground, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Sim",
          style: AppTheme.textTheme.bodyText1.copyWith(
              color: AppTheme.cuyuyuOrange, fontWeight: FontWeight.bold)),
      onPressed: () {
        _signOut();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        "Terminar Sassão",
        style: AppTheme.textTheme.headline6
            .copyWith(color: AppTheme.darkerText, fontWeight: FontWeight.bold),
      ),
      content: Text("Deseja realmente terminar sessão?"),
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

  void _signOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NavigationHomeScreen(),
      ));
    });
  }
}
