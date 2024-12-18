import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:untitled2/common/translate/app_local.dart';

import '../../../common/colors/theme_model.dart';
import '../../../common/components.dart';
import '../../../common/images/images.dart';
import '../../../common/translate/strings.dart';
import '../forget_password/forget_password.dart';
import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends StateMVC<LoginScreen> {
  _LoginSignupScreenState() : super(LoginController()) {
    con = LoginController();
  }
  late LoginController con;

  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode idFocusNode = FocusNode();
  bool activeBottom = false;
  bool activeBottomNew = false;
  bool isFocus1 = false;
  bool isFocus2 = false;

  @override
  void initState() {
    super.initState();
    idFocusNode.addListener(() {
      setState(() {
        isFocus1 = idFocusNode.hasFocus;
      });
    });
    passwordFocusNode.addListener(() {
      setState(() {
        isFocus2 = passwordFocusNode.hasFocus;
      });
    });

    // idController.addListener(() {
    //   setState(() {
    //     activeBottomNew = idController.text.length == 10;
    //   });
    // });

    // passwordController.addListener(() {
    //   setState(() {
    //     activeBottom = passwordController.text.length >= 8;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeModel.of(context).backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.logo),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 90, left: 20),
                color: ThemeModel.mainColor.withOpacity(.30),
              ),
            ),
          ),
          Positioned(
            top: 200,
            child: Container(
              //  height: 250,
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: AutofillGroup(
                  // onDisposeAction: AutofillContextAction.cancel,
                  child: Column(
                    children: [
                      buildTextField(
                        Icons.contact_mail_outlined,
                        Strings.iqamaNumber.tr(context),
                        false,
                        TextInputType.number,
                        isFocus1
                            ? ThemeModel.mainColor
                            : ThemeModel.of(context).greyFontColor,
                        con.idController,
                        10,
                        idFocusNode,
                        context,
                      ),
                      buildTextField(
                        Icons.lock_outline,
                        Strings.enterYourPassword.tr(context),
                        true,
                        TextInputType.text,
                        isFocus2
                            ? ThemeModel.mainColor
                            : ThemeModel.of(context).greyFontColor,
                        con.passwordController,
                        20,
                        passwordFocusNode,
                        context,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            TextInput.finishAutofillContext();
                            navigate(context, const ForgetPassword());
                          },
                          child: Text(
                            Strings.forgotPassword.tr(context),
                            style: TextStyle(
                                fontSize: 14,
                                color: ThemeModel.of(context).textColor1),
                          ),
                        ),
                      ),
                      con.loading
                          ? Center(
                              child: SpinKitWave(
                                  color: Colors.grey.shade600, size: 25.0))
                          : Center(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 35),
                                height: 70,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: bottom(
                                  Strings.login.tr(context),
                                  () {
                                    con.login(context);
                                  },
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
