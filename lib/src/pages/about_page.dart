//@dart=2.9
import 'dart:io';
import 'dart:ui';
import 'package:cuyuyu/src/components/bottom_nav_bar.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  bool _isAndroid = Platform.isAndroid;

  @override
  void initState() {
    super.initState();
    if (_isAndroid) {
      _isAndroid = Platform.isAndroid;
    } else {
      _isAndroid = Platform.isIOS;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.nearlyWhite,
      appBar: AppBar(
        title: const Text("Sobre Nós", style: AppTheme.title),
        elevation: 0,
        iconTheme: IconThemeData.fallback(),
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.nearlyBlack,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 150,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top, left: 16, right: 16),
            child: Image.asset(
              'images/app_logo.png',
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Versão 1.0',
                      style: AppTheme.title,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'CUYUYU ENTREGAS, é uma plataforma que permite que você receba os melhores '
                          'produtos da sua cidade em minutos. Diga o que deseja e um entregador Cuyuyu '
                          'levará aonde que que você esteja.',
                          style: AppTheme.display4,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Contactos',
                          style: AppTheme.display6,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 8),
                        SelectableText(
                          '+244 926 542 671',
                          style: AppTheme.display3,
                          toolbarOptions: ToolbarOptions(
                              copy: true,
                              selectAll: true,
                              cut: false,
                              paste: false),
                        ),
                        SizedBox(height: 8),
                        SelectableText(
                          '+244 926 682 532',
                          style: AppTheme.display3,
                          toolbarOptions: ToolbarOptions(
                              copy: true,
                              selectAll: true,
                              cut: false,
                              paste: false),
                        ),
                        SizedBox(height: 8),
                        SelectableText(
                          'cuyuyu.entregras@outlook.com',
                          style: AppTheme.display4.copyWith(
                              color: AppTheme.nearlyBlue,
                              fontWeight: FontWeight.w400),
                          toolbarOptions: ToolbarOptions(
                              copy: true,
                              selectAll: true,
                              cut: false,
                              paste: false),
                        ),
                        SizedBox(height: 8),
                        InkWell(
                          onTap: () => launch(
                              'https://web.facebook.com/Cuyuyu-Entregas-100721258317817'),
                          child: Text(
                            'Siga-nos no Facebook',
                            style: AppTheme.display4.copyWith(
                                color: AppTheme.nearlyBlue,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Divider(),
                        _isAndroid
                            ? ListTile(
                                leading: Icon(
                                  Icons.shop,
                                  color: AppTheme.nearlyBlue,
                                ),
                          trailing: Icon(Icons.chevron_right_rounded,
                              color: AppTheme.closeColor),
                                title: Text(
                                  'Avaliar na PlayStore',
                                  style: AppTheme.display4,
                                ),
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text('Enviado'),
                                    duration: Duration(milliseconds: 500),
                                  ));
                                },
                              )
                            : ListTile(
                                leading: Icon(Icons.shopping_basket,
                                    color: AppTheme.nearlyBlue),
                          trailing: Icon(Icons.chevron_right_rounded,
                              color: AppTheme.closeColor),
                                title: Text(
                                  'Avaliar na AppStore',
                                  style: AppTheme.display4,
                                ),
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text('Enviado'),
                                    duration: Duration(milliseconds: 500),
                                  ));
                                },
                              ),
                        Divider(),
                        ListTile(
                          leading:
                              Icon(Icons.feedback, color: AppTheme.nearlyBlue),
                          trailing: Icon(Icons.chevron_right_rounded,
                              color: AppTheme.closeColor),
                          title: Text('Enviar feedback',
                              style: AppTheme.display4),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Enviado'),
                              duration: Duration(milliseconds: 500),
                            ));
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading:
                              Icon(Icons.share, color: AppTheme.nearlyBlue),
                          trailing: Icon(Icons.chevron_right_rounded,
                              color: AppTheme.closeColor),
                          title: Text(
                            'Partilhar',
                            style: AppTheme.display4,
                          ),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('partilhado'),
                              duration: Duration(milliseconds: 500),
                            ));
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.visibility,
                              color: AppTheme.nearlyBlue),
                          trailing: Icon(Icons.chevron_right_rounded,
                          color: AppTheme.closeColor),
                          title: Text('Visitar nosso website',
                              style: AppTheme.display4),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Visitado'),
                              duration: Duration(milliseconds: 500),
                            ));
                          },
                        ),
                        Divider(),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () => launch('www.fenixinnovation.com'),
                          child: Text(
                            'Criado por Fênix Innovation Angola',
                            textAlign: TextAlign.center,
                            style: AppTheme.display1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
