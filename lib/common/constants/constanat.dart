import 'package:flutter/material.dart';
import '../../shared_prefrence/shared prefrence.dart';
import '../colors/theme_model.dart';

bool? isDark=Save.getdata(key: 'isdark')??false;
String ?language=Save.getdata(key: 'lang')??'ar';
dynamic token=Save.getdata(key: 'token');
ThemeData lightMode=ThemeData(
    fontFamily: language=='English Language'? 'fonten':'fontTop',
    primarySwatch: Colors.deepOrange,
    primaryColor:ThemeModel.mainColor
);
ThemeData darkMode=ThemeData(
  fontFamily: language=='English Language'? 'fonten':'fontTop',
  primaryColor: Colors.grey,
  brightness: Brightness.dark,
  hintColor: Colors.white,
  dividerColor: Colors.black12,
  appBarTheme: const AppBarTheme(
    color: Colors.black54,
  ),);


