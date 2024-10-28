import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:untitled2/common/translate/app_local.dart';
import 'package:untitled2/common/translate/strings.dart';
import '../../../common/components.dart';
import '../../../common/constants/constanat.dart';
import '../new_password/new_password.dart';
import 'check_otp_data_handler.dart';

class CheckOtpController extends ControllerMVC {
  // singleton
  factory CheckOtpController() {
    _this ??= CheckOtpController._();
    return _this!;
  }

  static CheckOtpController? _this;

  CheckOtpController._();
  bool loading = false;

  late TextEditingController otpCodeController;
  @override
  void initState() {
    super.initState();
    otpCodeController = TextEditingController();
  }

  @override
  void dispose() {
    otpCodeController.dispose();
    super.dispose();
  }

  ///   -----------   Login
  Future checkOtpCode(BuildContext context, String residencyNumber) async {
    loading = true;
    setState(() {});

    final result = await CheckOtpDataHandler.checkOTP(
      residencyNumber: residencyNumber,
      otpCode: otpCodeController.text,
    );

    result.fold((failure) {
      // Handle failure response, such as server exceptions
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade400,
        content: Align(
            alignment: Alignment.center,
            child: Text(
              Strings.failedCheckCode.tr(context),
              style: const TextStyle(color: Colors.white, fontSize: 17),
            )),
      ));
    }, (r) {
      if (r["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green.shade400,
          content: Align(
              alignment: Alignment.center,
              child: Text(
                Strings.checkCodeSuccessfully.tr(context),
                style: const TextStyle(color: Colors.white, fontSize: 17),
              )),
        ));
        token = r["token"];
        navigate(context, NewPassword(token: r["token"],));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red.shade400,
          content: Align(
              alignment: Alignment.center,
              child: Text(
                Strings.failedCheckCode.tr(context),
                style: const TextStyle(color: Colors.white, fontSize: 17),
              )),
        ));
      }
    });

    loading = false;
    setState(() {});
  }
}
