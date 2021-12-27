//@dart=2.9

import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:flutter/material.dart';

class ProductAddScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adicionar produto',
          style: TextStyle(
              color: AppColors.closeColor,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(),
    );
  }
}
