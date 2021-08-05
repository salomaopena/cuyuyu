//@dart=2.9
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: kPrimaryColor,
        onPressed: press,
        child: Text(
          text,
          style: AppTheme.display5
        ),
      ),
    );
  }
}
