import 'package:flutter/material.dart';

class ThemeModel {
  static ThemeModel of(BuildContext context) => ThemeModel.light();
  static ThemeModel get defaultTheme {
    return ThemeModel.light();
  }
  static const mainColor = Color(0xFFF78C2E);
  final Color backgroundColor;
  final Color textFieldColor;
  final Color textColor1;
  final Color greyFontColor ;
  final Color moneyColor;
  final Color brownColor;
  final Color cardColor;
  ThemeModel.light( {
    this.greyFontColor = Colors.grey,
    this.backgroundColor = const Color(0xFFECF3F9),
    this.textFieldColor = const Color(0XFFA7BCC7),
    this.textColor1 = const Color(0XFFA7BCC7),
    this.moneyColor = Colors.green,
    this.brownColor = Colors.brown,
    this.cardColor = Colors.white,
  }); // Safety check// Safety check
}
