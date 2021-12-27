//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

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
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w800,
              fontSize: 15,
              color: AppColors.closeColor,
            ),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: GestureDetector(
            onTap: press,
            child: Text(
              '',
              style: GoogleFonts.lato(
              ),
            ),
          ),
        )
      ],
    );
  }
}
