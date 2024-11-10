import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:untitled2/Utilities/shared_preferences.dart';
import 'package:untitled2/common/translate/app_local.dart';
import 'package:untitled2/common/translate/strings.dart';

import '../../../Utilities/NotificationHandler/notification_handler.dart';
import '../../../common/components.dart';
import '../../../model/get_rider_data_model.dart';
import '../../../shared_prefrence/shared prefrence.dart';
import '../../Profile/navigators/UserData/user_data_data_handler.dart';
import '../../home/screen/home.dart';
import 'login_data_handler.dart';

class LoginController extends ControllerMVC {
  // singleton
  factory LoginController() {
    _this ??= LoginController._();
    return _this!;
  }

  static LoginController? _this;

  LoginController._();
  bool loading = false;

  late TextEditingController idController;
  late TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  RiderData? userData;
  Future getUserData(BuildContext context) async {
    final result = await UserDataDataHandler.getUserData();
    result.fold((l) {}, (r) {
      userData = r;
      if (r.id != null) {
        SharedPref.setUserID(id: r.id!);
        final SocketService socketService = SocketService();
        if (SharedPref.getUserID() != null) {
          socketService.connectAndSubscribe(
            SharedPref.getUserID()!,
            "DELIVERY_PARTNER",
          );
        }
      }
    });
  }

  ///   -----------   Login
  Future login(BuildContext context) async {
    loading = true;
    setState(() {});
    final result = await LoginDataHandler.login(
        residencyNumber: idController.text, password: passwordController.text);
    result.fold((l) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade400,
        content: Align(
            alignment: Alignment.center,
            child: Text(
              Strings.loginFailed.tr(context),
              style: const TextStyle(color: Colors.white, fontSize: 17),
            )),
      ));
    }, (r) {
      SharedPref.setToken(token: r);
      SharedPref.setLoginState(true);
      Save.savedata(key: 'token', value: r);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green.shade400,
        content: Align(
            alignment: Alignment.center,
            child: Text(
              Strings.loginSuccessfully.tr(context),
              style: const TextStyle(color: Colors.white, fontSize: 17),
            )),
      ));
      getUserData(context);
      navigateAndFinish(context, const HomePage());
    });
    loading = false;
    setState(() {});
  }
}
