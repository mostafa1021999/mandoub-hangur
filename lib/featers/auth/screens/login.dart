import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:untitled2/common/translate/app_local.dart';
import 'package:untitled2/cubit/rider_cubit.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/components.dart';
import '../../../common/constants/constanat.dart';
import '../../../common/images/images.dart';
import '../../../common/translate/strings.dart';
import '../../home/screen/home.dart';
import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginScreen> {
  late TextEditingController idController;
  late TextEditingController passwordController;
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode idFocusNode = FocusNode();
  bool activeBottom = false;
  bool activeBottomNew = false;
  bool isFocus1 = false;
  bool isFocus2 = false;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    passwordController = TextEditingController();
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

    idController.addListener(() {
      setState(() {
        activeBottomNew = idController.text.length == 10;
      });
    });

    passwordController.addListener(() {
      setState(() {
        activeBottom = passwordController.text.length >= 8;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RiderCubit, MandoubState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green.shade400,
              content:  Align(
                  alignment: Alignment.center,child: Text(language=='English Language'?"Login successfully":'تم تسجيل الدخول بنجاح',style: TextStyle(color: Colors.white,fontSize: 17),)),
            ));
          });
          navigateAndFinish(context, const HomePage());
        } else if (state is LoginError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red.shade400,
              content:  Align(
                  alignment: Alignment.center,child: Text(language=='English Language'?"Residency number or Password is not valid":'رقم الاقامة او كلمة المرور خطاء',style: TextStyle(color: Colors.white,fontSize: 17),)),
            ));
          });
        }
      },
      builder: (context, state) {
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
                    padding: EdgeInsets.only(top: 90, left: 20),
                    color: ThemeModel.mainColor.withOpacity(.30),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 700),
                curve: Curves.bounceInOut,
                top: 200,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 700),
                  curve: Curves.bounceInOut,
                  height: 250,
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width - 40,
                  margin: EdgeInsets.symmetric(horizontal: 20),
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
                  child: SingleChildScrollView(
                    child: buildSigninSection(),
                  ),
                ),
              ),
              state is LoginLoading
                  ? Center(child: SpinKitWave(
                  color: Colors.grey.shade600,
                  size: 25.0))
                  : buildBottomHalfContainer(
                  false, idController.text, passwordController.text),
            ],
          ),
        );
      },
    );
  }

  Container buildSigninSection() {
     bool password=true;
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(
            Icons.contact_mail_outlined,
            Strings.iqamaNumber.tr(context),
            false,
            TextInputType.number,
            isFocus1 ? ThemeModel.mainColor : ThemeModel.of(context).greyFontColor,
            idController,
            10,
            idFocusNode,
            context,
          ),
          buildTextField(
            Icons.lock_outline,
            Strings.enterYourPassword.tr(context),
            true,
            TextInputType.text,
            isFocus2 ? ThemeModel.mainColor : ThemeModel.of(context).greyFontColor,
            passwordController,
            20,
            passwordFocusNode,
            context,
          ),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                navigate(context, ForgetPassword());
              },
              child: Text(
                Strings.forgotPassword.tr(context),
                style: TextStyle(fontSize: 14, color: ThemeModel.of(context).textColor1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomHalfContainer(bool showShadow, String id, String password) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 35),
        height: 70,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: bottom(
          Strings.login.tr(context),
          activeBottom && activeBottomNew
              ? () {
            RiderCubit.get(context).riderLogin(
              residencyNumber: id,
              password: password,
              context: context,
            );
          }
              : null,
        ),
      ),
    );
  }
}