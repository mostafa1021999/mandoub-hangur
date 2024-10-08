import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../../model/get_rider_data_model.dart';
import 'user_data_data_handler.dart';

class UserDataController extends ControllerMVC {
  // singleton
  factory UserDataController() {
    _this ??= UserDataController._();
    return _this!;
  }

  static UserDataController? _this;

  UserDataController._();
  bool loading = false;

  ///   -----------   get user Data   -----------
  RiderData? userData;
  Future getUserData(BuildContext context) async {
    loading = true;
    setState(() {});
    final result = await UserDataDataHandler.getUserData();
    result.fold((l) {}, (r) {
      userData = r;
    });
    loading = false;
    setState(() {});
  }
}
