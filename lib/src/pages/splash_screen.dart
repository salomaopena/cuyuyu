import 'package:cuyuyu/src/custom_drawer/navigation_home_screen.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:flutter/material.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    var duration = Duration(seconds: 3);
    Future.delayed(duration, () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return NavigationHomeScreen();
        },
      ), (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopAppTheme.buildLightTheme().backgroundColor,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          scale: 3,
          repeat: ImageRepeat.noRepeat,
          image: AssetImage('images/app_logo.png'),
        )),
      ),
    );
  }
}
