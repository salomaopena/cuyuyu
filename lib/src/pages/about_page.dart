import 'dart:io';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
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
    return Container(
      color: ShopAppTheme.buildLightTheme().backgroundColor,
      child: SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              Container(
                height: 160,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 16,
                    right: 16),
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
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                      fontFamily: 'Raleway', fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Contactos',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(
                                      fontFamily: 'Raleway', fontSize: 20),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 8),
                            SelectableText(
                              '+244 926 542 671',
                              style: AppTheme.textTheme.bodyText2.copyWith(
                                  color: AppTheme.darkerText,
                                  fontWeight: FontWeight.bold),
                              toolbarOptions: ToolbarOptions(
                                  copy: true,
                                  selectAll: true,
                                  cut: false,
                                  paste: false),
                            ),
                            SizedBox(height: 8),
                            SelectableText(
                              '+244 926 682 532',
                              style: AppTheme.textTheme.bodyText2.copyWith(
                                  color: AppTheme.darkerText,
                                  fontWeight: FontWeight.bold),
                              toolbarOptions: ToolbarOptions(
                                  copy: true,
                                  selectAll: true,
                                  cut: false,
                                  paste: false),
                            ),
                            SizedBox(height: 8),
                            SelectableText(
                              'cuyuyu.entregras@outlook.com',
                              style: AppTheme.textTheme.bodyText2.copyWith(
                                  color: AppTheme.nearlyBlue,
                                  fontWeight: FontWeight.bold),
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
                                style: AppTheme.textTheme.bodyText2.copyWith(
                                    color: AppTheme.nearlyBlue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            _isAndroid
                                ? ListTile(
                                    leading: Icon(
                                      Icons.shop,
                                      color: AppTheme.nearlyBlue,
                                    ),
                                    title: Text(
                                      'Avaliar na PlayStore',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(
                                              fontFamily: 'Raleway',
                                              fontSize: 14),
                                    ),
                                    onTap: () {
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text('Enviado'),
                                        duration: Duration(milliseconds: 500),
                                      ));
                                    },
                                  )
                                : ListTile(
                                    leading: Icon(Icons.shopping_basket,
                                        color: AppTheme.nearlyBlue),
                                    title: Text(
                                      'Avaliar na AppStore',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(
                                              fontFamily: 'Raleway',
                                              fontSize: 14),
                                    ),
                                    onTap: () {
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text('Enviado'),
                                        duration: Duration(milliseconds: 500),
                                      ));
                                    },
                                  ),
                            Divider(),
                            ListTile(
                              leading: Icon(Icons.feedback,
                                  color: AppTheme.nearlyBlue),
                              title: Text('Enviar feedback',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                          fontFamily: 'Raleway', fontSize: 14)),
                              onTap: () {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Enviado'),
                                  duration: Duration(milliseconds: 500),
                                ));
                              },
                            ),
                            Divider(),
                            ListTile(
                              leading:
                                  Icon(Icons.share, color: AppTheme.nearlyBlue),
                              title: Text(
                                'Partilhar',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        fontFamily: 'Raleway', fontSize: 14),
                              ),
                              onTap: () {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('partilhado'),
                                  duration: Duration(milliseconds: 500),
                                ));
                              },
                            ),
                            Divider(),
                            ListTile(
                              leading: Icon(Icons.visibility,
                                  color: AppTheme.nearlyBlue),
                              title: Text('Visitar nosso website',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                          fontFamily: 'Raleway', fontSize: 14)),
                              onTap: () {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Visitado'),
                                  duration: Duration(milliseconds: 500),
                                ));
                              },
                            ),
                            Divider(),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () => launch('www.fenixinnovation.com'),
                              child: Text(
                                'Criado por Fênix Innovation Angola',
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                        color: AppTheme.darkerText,
                                        fontFamily: 'Raleway',
                                        fontSize: 16),
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
        ),
      ),
    );
  }
}
