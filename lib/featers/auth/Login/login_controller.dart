import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:untitled2/Utilities/shared_preferences.dart';
import 'package:untitled2/common/translate/app_local.dart';
import 'package:untitled2/common/translate/strings.dart';

import '../../../common/components.dart';
import '../../../common/constants/constanat.dart';
import '../../../shared_prefrence/shared prefrence.dart';
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
      navigateAndFinish(context, const HomePage());
    });
    loading = false;
    setState(() {});
  }
}
