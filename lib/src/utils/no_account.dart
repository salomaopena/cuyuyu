//@dart=2.9
import 'package:cuyuyu/src/users/register_page.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoAccountText extends StatefulWidget {
  const NoAccountText({Key key}) : super(key: key);

  @override
  _NoAccountTextState createState() => _NoAccountTextState();
}

class _NoAccountTextState extends State<NoAccountText> {

  @override
  Widget build(BuildContext context) {
    return  Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Text(
              "Não possui conta? ",
              style: AppTheme.display6.copyWith(
                  fontSize: getProportionateScreenWidth(16),
                  color: AppTheme.deactivatedText),
                textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  Get.to(()=>RegisterPage());
                });
              },
              child: Text(
                "Cadastre-se",
                style: AppTheme.display6.copyWith(
                    fontSize: getProportionateScreenWidth(16),
                    color: AppTheme.closeColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
    );
  }

}
