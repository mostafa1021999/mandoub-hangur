import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:untitled2/common/translate/app_local.dart';
import 'package:untitled2/common/translate/strings.dart';
import 'package:untitled2/featers/home/screen/home.dart';
import '../../../Utilities/shared_preferences.dart';
import '../../../common/components.dart';
import '../new_password/new_password.dart';
import 'new_password_data_handler.dart';

class NewPasswordController extends ControllerMVC {
  // singleton
  factory NewPasswordController() {
    _this ??= NewPasswordController._();
    return _this!;
  }

  static NewPasswordController? _this;

  NewPasswordController._();
  bool loading = false;

  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  ///   -----------   Login
  Future newPassword(BuildContext context,String token) async {
    loading = true;
    setState(() {});

    final result = await NewPasswordDataHandler.checkOTP(
      token: token,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
    );

    result.fold((failure) {
      // Handle failure response, such as server exceptions
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade400,
        content: Align(
            alignment: Alignment.center,
            child: Text(
              Strings.passwordNotMatch.tr(context),
              style: const TextStyle(color: Colors.white, fontSize: 17),
            )),
      ));
    }, (r) {
      SharedPref.setToken(token: token);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green.shade400,
          content: Align(
              alignment: Alignment.center,
              child: Text(
                Strings.passwordChangedSuccessfully.tr(context),
                style: const TextStyle(color: Colors.white, fontSize: 17),
              )),
        ));
        navigate(context,const HomePage());
    });
    loading = false;
    setState(() {});
  }
}
