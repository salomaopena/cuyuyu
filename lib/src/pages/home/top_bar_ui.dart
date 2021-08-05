//@dart=2.9
import 'package:cuyuyu/src/pages/section_title.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:flutter/material.dart';

class TopBarUI extends StatelessWidget {
  const TopBarUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Stack(
      children: <Widget>[
        Container(
          color: AppTheme.nearlyWhite,
          child: Padding(
            padding:
            const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SectionTitle(title: "Lojas mais populares", press: () {}),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
