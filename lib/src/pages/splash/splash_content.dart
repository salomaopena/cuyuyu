//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          "CUYUYU",
          style: TextStyle(
            fontSize: 36,
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,

        ),
        Spacer(flex: 2),
        Image.asset(
          image,
          height: 265,
          width: 235,
        ),
      ],
    );
  }
}