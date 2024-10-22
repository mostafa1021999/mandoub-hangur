import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinput/pinput.dart';
import 'package:untitled2/common/translate/app_local.dart';
import 'package:untitled2/cubit/rider_cubit.dart';
import 'package:untitled2/featers/auth/new_password/new_password_controller.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/components.dart';
import '../../../common/images/images.dart';
import '../../../common/translate/strings.dart';

class NewPassword extends StatefulWidget {
  String token;
  NewPassword({super.key, required this.token});
  @override
  NewPasswordState createState() => NewPasswordState();
}

class NewPasswordState extends StateMVC<NewPassword> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool isFocus1=false;
  bool isFocus2=false;
  //======================
  NewPasswordState() : super(NewPasswordController()) {
    con = NewPasswordController();
  }
  late NewPasswordController con;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordFocusNode.addListener((){setState(() {
      isFocus1=passwordFocusNode.hasFocus;
    });});
    confirmPasswordFocusNode.addListener((){setState(() {
      isFocus2=confirmPasswordFocusNode.hasFocus;
    });});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RiderCubit, MandoubState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(Images.logoWithoutBackground),
              buildTextField(Icons.password, Strings.enterNewPassword.tr(context), true,TextInputType.text,isFocus1?ThemeModel.mainColor:ThemeModel.of(context).greyFontColor, con.passwordController,20,passwordFocusNode,context ),
                const SizedBox(height: 5,),
                buildTextField(Icons.password, Strings.confirmNewPassword.tr(context), true, TextInputType.text,isFocus2?ThemeModel.mainColor:ThemeModel.of(context).greyFontColor,con.confirmPasswordController,20,confirmPasswordFocusNode,context),
              const SizedBox(height: 10,),
                con.loading? Center(
                    child: SpinKitWave(color: Colors.grey.shade600, size: 25.0)):
                bottom(Strings.changePassword.tr(context),(){
                  if(_formKey.currentState!.validate()){
                    if(con.passwordController.text==con.confirmPasswordController.text){
                      con.newPassword(context,widget.token);
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red.shade400,
                        content: Align(
                            alignment: Alignment.center,
                            child: Text(
                              Strings.passwordNotMatch.tr(context),
                              style: const TextStyle(color: Colors.white, fontSize: 17),
                            )),
                      ));
                    }
                  }
               })
            ],),
          ),
        ),
      ),
    );
  },
);
  }
}
