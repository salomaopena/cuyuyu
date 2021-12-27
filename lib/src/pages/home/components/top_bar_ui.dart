//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/common/section_title.dart';
import 'package:flutter/material.dart';

class TopBarUI extends StatelessWidget {
  const TopBarUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Stack(
      children: <Widget>[
        Container(
          color: AppColors.shopbackground,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 8) ,
          child: Row(
            children: <Widget>[
              Expanded(
                child: SectionTitle(title: 'Encontre tudo o que deseja', press: () {}),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
