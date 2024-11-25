import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled2/cubit/rider_cubit.dart';
import 'package:untitled2/shared_prefrence/shared%20prefrence.dart';

import 'Utilities/FilesHandler/files_cubit.dart';
import 'Utilities/NotificationHandler/notification_display_handler.dart';
import 'Utilities/NotificationHandler/notification_handler.dart';
import 'Utilities/git_it.dart';
import 'Utilities/shared_preferences.dart';
import 'common/constants/constanat.dart';
import 'common/translate/app_local.dart';
import 'dio/dio.dart';
import 'featers/Notifications/cubit/notifications_cubit.dart';
import 'featers/auth/Login/login.dart';
import 'featers/home/screen/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.initialize((payload) {
    if (payload != null && payload.isNotEmpty) {
      // Handle notification tap by navigating to a specific screen
      print('Notification tapped with payload: $payload');
      // Navigate to a specific screen, for example:
      // MyApp.navigatorKey.currentState?.push(
      //   MaterialPageRoute(
      //     builder: (context) => OrderDetails(
      //       orderIndex: int.parse(payload),
      //     ),
      //   ),
      // );
    }
  });
  print(token);
  await GitIt.initGitIt();
  DioHelper.init();
  await Save.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SocketService _socketService = SocketService();
  @override
  void initState() {
    if (SharedPref.getUserID() != null) {
      _socketService.connectAndSubscribe(
        SharedPref.getUserID()!,
        "DELIVERY_PARTNER",
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RiderCubit()..changeLanguage(fromCache: 'ar'),
          ),
          BlocProvider(create: (context) => DragFilesCubit()),
          BlocProvider(create: (context) => NotificationsCubit()),
        ],
        child: BlocBuilder<RiderCubit, MandoubState>(builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(428, 926),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Mandoub Hangur',
              darkTheme: darkMode,
              themeMode: isDark ?? false ? ThemeMode.dark : ThemeMode.light,
              home: SharedPref.getToken() != null
                  ? const HomePage()
                  : LoginScreen(),
              locale: Locale(language ?? 'ar'),
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
