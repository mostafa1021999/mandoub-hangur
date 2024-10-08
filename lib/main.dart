import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled2/cubit/rider_cubit.dart';
import 'package:untitled2/shared_prefrence/shared%20prefrence.dart';

import 'Utilities/git_it.dart';
import 'common/constants/constanat.dart';
import 'common/translate/app_local.dart';
import 'dio/dio.dart';
import 'featers/auth/Login/login.dart';
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
        create: (context) =>
            RiderCubit()..changeLanguage(fromCache: language ?? 'ar'),
        child: BlocBuilder<RiderCubit, MandoubState>(builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(428, 926),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Mandoub Hangur',
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
            ),
          );
        }));
  }
}
