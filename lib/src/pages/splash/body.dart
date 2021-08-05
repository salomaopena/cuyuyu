//@dart=2.9
import 'package:cuyuyu/src/pages/home/home_screen.dart';
import 'package:cuyuyu/src/pages/splash/splash_content.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/custom_button.dart';
import 'package:cuyuyu/src/utils/progress_dialog.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ProgressDialog pr;
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Seja bem-vindo a Cuyuyu Entregas",
      "image": "images/app_logo.png"
    },
    {
      "text":
          "Ajudamos a conectar as pessoas \nao produto que mais desejam em toda \nextensão de Angola",
      "image": "images/s1.png"
    },
    {
      "text":
          "Mostramos as pessoas a forma mais \nsimples de obter o produto sem se mover.",
      "image": "images/s3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(20),
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    OpenFlutterButton(
                      title: 'Continuar',
                      width: getProportionateScreenWidth(160),
                      height: getProportionateScreenHeight(48),
                      onPressed: () {
                        setState(() {
                          pr.style(
                              message: 'Aguarde...',
                              borderRadius: 10.0,
                              backgroundColor: Colors.white,
                              progressWidget: CircularProgressIndicator(),
                              elevation: 10.0,
                              insetAnimCurve: Curves.easeInOut,
                              progress: 0.0,
                              maxProgress: 100.0,
                              progressTextStyle: AppTheme.caption,
                              messageTextStyle: AppTheme.display6);
                          pr.show();
                          Future.delayed(Duration(seconds: 5)).then((value) {
                            pr.hide().whenComplete(() {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                      (Route<dynamic> route) => false);
                            });
                          });
                        });
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
