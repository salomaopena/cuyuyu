//@dart=2.9
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    @required this.title,
    @required this.press,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 4,
          fit: FlexFit.tight,
          child: Text(
            title,
            style: AppTheme.subtitle.copyWith(
                fontWeight: FontWeight.w600,
                fontFamily: 'Muli',
                fontSize: getProportionateScreenHeight(20)),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: GestureDetector(
            onTap: press,
            child: Text(
              "Mais lojas",
              style: AppTheme.caption.copyWith(fontFamily: 'Muli'),
            ),
          ),
        )
      ],
    );
  }
}
