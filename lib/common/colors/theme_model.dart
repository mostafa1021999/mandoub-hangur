import 'package:flutter/material.dart';

abstract class ThemeModelInterface {
  Color get backgroundColor;
  Color get textFieldColor;
  Color get textColor1;
  Color get greyFontColor;
  Color get moneyColor;
  Color get brownColor;
  Color get cardColor;
}

class LightTheme implements ThemeModelInterface {
  @override
  final Color greyFontColor = Colors.grey;
  @override
  final Color backgroundColor = const Color(0xFFECF3F9);
  @override
  final Color textFieldColor = const Color(0XFFA7BCC7);
  @override
  final Color textColor1 = const Color(0XFFA7BCC7);
  @override
  final Color moneyColor = Colors.green;
  @override
  final Color brownColor = Colors.brown;
  @override
  final Color cardColor = Colors.white;
}

class ThemeModelFactory {
  /// [context] - The build context used to determine the current theme settings.
  static ThemeModelInterface of() {
    return LightTheme();
  }

  // static ThemeModelInterface getDefaultTheme() {
  //   Brightness brightness =
  //       SchedulerBinding.instance.platformDispatcher.platformBrightness;
  //   return brightness == Brightness.dark ? DarkThemeModel() : LightThemeModel();
  // }
}

class ThemeModel {
  static ThemeModel of(BuildContext context) => ThemeModel.light();
  static ThemeModel get defaultTheme {
    return ThemeModel.light();
  }

  static const mainColor = Color(0xFFF78C2E);
  final Color primary;
  final Color backgroundColor;
  final Color cardsColor;
  final Color textFieldColor;
  final Color textColor1;
  final Color greyFontColor;
  final Color moneyColor;
  final Color brownColor;
  final Color cardColor;
  final Color font1;
  final Color font2;
  final Color font3;
  final Color font4;
  final Color chatTextField;
  final Color red;
  final Color danger;
  final Color greenAppBar;
  ThemeModel.light({
    this.primary = const Color(0xffF78C2E),
    this.greenAppBar = const Color(0xff33C072),
    this.danger = const Color(0xFFF04940),
    this.red = const Color(0xFFEB5757),
    this.cardsColor = const Color(0xFFFFFFFF),
    this.greyFontColor = Colors.grey,
    this.backgroundColor = const Color(0xFFECF3F9),
    this.textFieldColor = const Color(0XFFA7BCC7),
    this.textColor1 = const Color(0XFFA7BCC7),
    this.moneyColor = Colors.green,
    this.brownColor = Colors.brown,
    this.cardColor = Colors.white,
    this.font1 = const Color(0xFF0E111A),
    this.font2 = const Color(0xFF878787),
    this.font3 = const Color(0xFFC5C5C5),
    this.font4 = const Color(0xFFE5E5E5),
    this.chatTextField = Colors.black12,
  }); // Safety check// Safety check
}
