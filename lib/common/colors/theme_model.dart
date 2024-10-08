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
  final Color backgroundColor;
  final Color textFieldColor;
  final Color textColor1;
  final Color greyFontColor;
  final Color moneyColor;
  final Color brownColor;
  final Color cardColor;
  ThemeModel.light({
    this.greyFontColor = Colors.grey,
    this.backgroundColor = const Color(0xFFECF3F9),
    this.textFieldColor = const Color(0XFFA7BCC7),
    this.textColor1 = const Color(0XFFA7BCC7),
    this.moneyColor = Colors.green,
    this.brownColor = Colors.brown,
    this.cardColor = Colors.white,
  }); // Safety check// Safety check
}
