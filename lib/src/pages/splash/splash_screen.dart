import 'package:cuyuyu/src/pages/splash/body.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    return Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}