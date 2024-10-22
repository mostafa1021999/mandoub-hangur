import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:untitled2/common/translate/app_local.dart';
import 'package:untitled2/common/translate/strings.dart';
import 'package:untitled2/featers/auth/forget_password/forget_password_data_handler.dart';
import '../../../common/components.dart';
import '../../../common/constants/constanat.dart';
import '../check_otp/check_otp.dart';

class ForgetPasswordController extends ControllerMVC {
  // singleton
  factory ForgetPasswordController() {
    _this ??= ForgetPasswordController._();
    return _this!;
  }

  static ForgetPasswordController? _this;

  ForgetPasswordController._();
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

  Future sendCode(BuildContext context) async {
    loading = true;
    setState(() {});
    final result = await ForgetPasswordDataHandler.sendOTP(
        residencyNumber: idController.text, language: language??'ar');
    result.fold((l) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade400,
        content: Align(
            alignment: Alignment.center,
            child: Text(
              Strings.failedSendOtp.tr(context),
              style: const TextStyle(color: Colors.white, fontSize: 17),
            )),
      ));
    }, (r) {
      if (r["success"] == true) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green.shade400,
          content: Align(
            alignment: Alignment.center,
            child: Text(
              Strings.codeSentSuccessfully.tr(context),
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ));

        // Navigate with phone number
        navigate(context, OtpNumber(endPhoneNumber: r["phoneNumber"],residencyNumber: idController.text,));
      } else {
        // Handle case where status is false (OTP not sent)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red.shade400,
          content: Align(
            alignment: Alignment.center,
            child: Text(
              Strings.failedSendOtp.tr(context),
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ));
      }
    });
    loading = false;
    setState(() {});
  }
}
