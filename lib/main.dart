import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:untitled2/cubit/rider_cubit.dart';
import 'package:untitled2/shared_prefrence/shared%20prefrence.dart';

import 'Utilities/git_it.dart';
import 'common/constants/constanat.dart';
import 'common/translate/app_local.dart';
import 'dio/dio.dart';
import 'featers/auth/screens/login.dart';
import 'featers/home/screen/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GitIt.initGitIt();
  DioHelper.init();
  await Save.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RiderCubit()
          ..getRiderData()
          ..changeLanguage(fromCache: language ?? 'ar'),
        child: BlocBuilder<RiderCubit, MandoubState>(builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Bottom Sheet Example',
            darkTheme: darkMode,
            themeMode: isDark ?? false ? ThemeMode.dark : ThemeMode.light,
            home: token != null ? const HomePage() : LoginScreen(),
            locale: Locale(RiderCubit.get(context).lang),
            localizationsDelegates: const [
              AppLocale.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ar'), // Arabic
              Locale('en'), // English
            ],
          );
        }));
  }
}
