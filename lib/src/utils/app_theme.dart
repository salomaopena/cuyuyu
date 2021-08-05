//@dart=2.9
import 'package:flutter/material.dart';

import '../../main.dart';

class AppTheme {
  AppTheme._();

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);

  static const Color cuyuyuOrange100 = Color(0xFFFFE0B2);
  static const Color cuyuyuOrange200 = Color(0xFFffCC80);
  static const Color cuyuyuOrange300 = Color(0xFFFFB74D);
  static const Color cuyuyuOrange400 = Color(0xFFFFA726);
  static const Color cuyuyuOrange = Color(0xFFF5984B);
  static const Color cuyuyuLigthBlue = Color(0xFF4BCCf5);
  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color cuyutyuBlue = Color(0xFF348FAB);
  static const Color cuyuyuYellow = Color(0xFFF5CB4B);
  static const Color cuyuyuDarkYellow = Color(0xFFAB8E34);
  static const Color transparentYellow = Color.fromRGBO(253, 184, 70, 0.7);
  static const Color closeColor = Color(0xFFFF7643);
  static const Color nearlyGreen = Color(0xFF54D3C2);
  static const Color redColor = Color(0xFFF00000);

  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);
  static const Color cuyuyuSurfaceWhite = Color(0xFFFFFBFA);
  static const Color cuyuyuBackgroundWhite = Colors.white;
  static const Color cuyuyuTransparent = Colors.transparent;
  static const Color  shopbackground= Color(0xFFF5F6F9);

  static const LinearGradient mainButton = LinearGradient(colors: [
    Color.fromRGBO(236, 60, 3, 1),
    Color.fromRGBO(234, 60, 3, 1),
    Color.fromRGBO(216, 78, 16, 1),
  ], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);

  static const String fontName = "Metropolis";

  static const TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );

  static const TextStyle headline = TextStyle(
    // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.w900,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    // h6 -> title
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 20,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle display1 = TextStyle(
    // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle display2 = TextStyle(
    color: nearlyBlack,
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static const TextStyle display3 = TextStyle(
    fontSize: 15,
    color: nearlyBlack,
    fontWeight: FontWeight.w400,
    fontFamily: fontName,
    letterSpacing: 0.5,
  );

  static const TextStyle display4 = TextStyle(
    fontSize: 14,
    color: nearlyBlack,
    fontWeight: FontWeight.w400,
    fontFamily: fontName,
  );

  static const TextStyle display5 = TextStyle(
    fontSize: 18,
    color: nearlyWhite,
    fontWeight: FontWeight.w400,
    fontFamily: fontName,
    letterSpacing: 0.5,
  );

  static const TextStyle display6 = TextStyle(
    fontSize: 18,
    color: nearlyBlack,
    fontWeight: FontWeight.w500,
    fontFamily: 'Muli',
    letterSpacing: 0.5,
  );

  static const TextStyle subtitle = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    fontSize: 18,
    color: darkText,
  );



  static const TextStyle caption = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

  static const TextStyle body1 = TextStyle(
    // body2 -> body1
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 11,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    // body1 -> body2
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 11,
    letterSpacing: 0.2,
    color: nearlyWhite,
  );

  static TextTheme _buildTextTheme(TextTheme base) {
    const String fontName = 'Metropolis';
    return base.copyWith(
      headline1: base.headline1.copyWith(fontFamily: fontName),
      headline2: base.headline2.copyWith(fontFamily: fontName),
      headline3: base.headline3.copyWith(fontFamily: fontName),
      headline4: base.headline4.copyWith(fontFamily: fontName),
      headline5: base.headline5.copyWith(fontFamily: fontName),
      headline6: base.headline6.copyWith(fontFamily: fontName),
      button: base.button.copyWith(fontFamily: fontName),
      caption: base.caption.copyWith(fontFamily: fontName),
      bodyText1: base.bodyText1.copyWith(fontFamily: fontName),
      bodyText2: base.bodyText2.copyWith(fontFamily: fontName),
      subtitle1: base.subtitle1.copyWith(fontFamily: fontName),
      subtitle2: base.subtitle2.copyWith(fontFamily: fontName),
      overline: base.overline.copyWith(fontFamily: fontName),
    );
  }

  static ThemeData buildLightTheme() {
    final Color primaryColor = HexColor('#54D3C2  ');
    final Color secondaryColor = HexColor('#54D3C2');
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );


    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      buttonColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: secondaryColor,
      canvasColor: Colors.white,
      backgroundColor: const Color(0xFFFFFFFF),
      scaffoldBackgroundColor: const Color(0xFFF6F6F6),
      errorColor: const Color(0xFFF00000),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
      platform: TargetPlatform.iOS,
    );
  }
}
