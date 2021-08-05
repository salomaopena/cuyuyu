import 'package:cuyuyu/src/components/bottom_nav_bar.dart';
import 'package:cuyuyu/src/pages/privacy_policy.dart';
import 'package:cuyuyu/src/pages/terms_and_conditions.dart';
import 'package:cuyuyu/src/users/change_password.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/enums.dart';
import 'package:flutter/material.dart';
import 'notifications_page.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Definições", style: AppTheme.title),
        elevation: 0,
        iconTheme: IconThemeData.fallback(),
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.nearlyBlack,
      ),
      backgroundColor: AppTheme.nearlyWhite,
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: EdgeInsets.only(top: 40.0, left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0, top: 80.0),
                    child: Text(
                      'Geral',
                      style: AppTheme.subtitle.copyWith(
                          color: AppTheme.cuyuyuOrange,),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Termos de uso',
                      style: AppTheme.display4.copyWith(
                          color: AppTheme.cuyutyuBlue,
                        fontFamily: 'Muli'
                      ),
                    ),
                    leading: Icon(
                      Icons.list,
                      color: AppTheme.cuyuyuLigthBlue,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => TermsPage()));
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Privacidade',
                      style: AppTheme.display4.copyWith(
                          color: AppTheme.cuyutyuBlue,
                      fontFamily: 'Muli'),
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
                      'Activar notificações',
                      style: AppTheme.display4.copyWith(
                          color: AppTheme.cuyutyuBlue,
                          fontFamily: 'Muli'),
                    ),
                    leading: Icon(
                      Icons.notifications,
                      color: AppTheme.cuyuyuLigthBlue,
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NotificationPage()));
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                    child: Text(
                      'Conta',
                      style: AppTheme.subtitle.copyWith(
                          color: AppTheme.cuyuyuOrange),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Alterar Senha',
                      style: AppTheme.display4.copyWith(
                          color: AppTheme.cuyutyuBlue,
                      fontFamily: 'Muli'),
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
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
