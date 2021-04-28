import 'package:cuyuyu/src/pages/chat_page.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatelessWidget {
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 60.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 250,
                        child: AspectRatio(
                          aspectRatio: 2,
                          child: Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).padding.top,
                                left: 16,
                                right: 16),
                            child: Image.asset('images/app_logo.png'),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Como podemos ajudar?',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 16),
                        child: const Text(
                          'Parece que você está tendo problemas \ncom nossos serviços. Estamos aqui para \najudar, portanto, entre em contato conosco',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      SelectableText(
                        '+244 926 542 671',
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
                      SelectableText(
                        '+244 926 682 532',
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
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Container(
                            width: 140,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppTheme.nearlyBlue,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.6),
                                    offset: const Offset(4, 4),
                                    blurRadius: 8.0),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  if (FirebaseAuth.instance.currentUser !=
                                      null) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => HelpPage(),
                                    ));
                                  } else {
                                    Toast.show(
                                        "Inicie sessão para ter acesso ao chat",
                                        context,
                                        gravity: Toast.CENTER,
                                        duration: Toast.LENGTH_LONG);
                                  }
                                },
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Nosso chat',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
