//@dart=2.9
import 'package:cuyuyu/src/components/bottom_nav_bar.dart';
import 'package:cuyuyu/src/pages/chat_page.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/custom_button.dart';
import 'package:cuyuyu/src/utils/enums.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.nearlyWhite,
      appBar: AppBar(
        title: const Text("Apoio & Ajuda", style: AppTheme.title),
        elevation: 0,
        iconTheme: IconThemeData.fallback(),
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.nearlyBlack,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: getProportionateScreenHeight(250),
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
                      style: AppTheme.display6,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: const Text(
                      'Parece que você está tendo problemas \ncom nossos serviços. Estamos aqui para \najudar, portanto, entre em contato conosco',
                      textAlign: TextAlign.center,
                      style:AppTheme.display4,
                    ),
                  ),
                  SizedBox(height: 20),
                  SelectableText(
                    '+244 926 542 671',
                    style: AppTheme.display4.copyWith(
                        color: AppTheme.nearlyBlue,
                        fontWeight: FontWeight.bold),
                    toolbarOptions: ToolbarOptions(
                        copy: true, selectAll: true, cut: false, paste: false),
                  ),
                  SizedBox(height: 8),
                  SelectableText(
                    '+244 926 682 532',
                    style: AppTheme.display4.copyWith(
                        color: AppTheme.nearlyBlue,
                        fontWeight: FontWeight.bold),
                    toolbarOptions: ToolbarOptions(
                        copy: true, selectAll: true, cut: false, paste: false),
                  ),
                  SizedBox(height: 8),
                  SelectableText(
                    'cuyuyu.entregras@outlook.com',
                    style: AppTheme.display4.copyWith(
                        color: AppTheme.nearlyBlue,
                        fontWeight: FontWeight.bold),
                    toolbarOptions: ToolbarOptions(
                        copy: true, selectAll: true, cut: false, paste: false),
                  ),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: () => launch(
                        'https://web.facebook.com/Cuyuyu-Entregas-100721258317817'),
                    child: Text(
                      'Siga-nos no Facebook',
                      style: AppTheme.display4.copyWith(
                          color: AppTheme.nearlyBlue),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: OpenFlutterButton(
                          title: "Nosso Chat",
                          width: getProportionateScreenWidth(300),
                          onPressed: (){
                            if (FirebaseAuth.instance.currentUser != null) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HelpPage(),
                              ));
                            } else {
                              Toast.show(
                                  "Inicie sessão para ter acesso ao chat",
                                  context,
                                  gravity: Toast.CENTER,
                                  duration: Toast.LENGTH_LONG);
                            }
                          })
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
