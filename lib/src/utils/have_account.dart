//@dart=2.9
import 'package:cuyuyu/src/users/login_page.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HaveAccount extends StatelessWidget {
  const HaveAccount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Text(
            "Já possui uma conta? ",
            style: AppTheme.display6.copyWith(
                fontSize: getProportionateScreenWidth(14),
                color: AppTheme.deactivatedText),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
                Get.to(()=>LoginPage());
            },
            child: Text(
              "Inicie sessão",
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
