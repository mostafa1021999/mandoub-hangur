import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:untitled2/common/translate/app_local.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/components.dart';
import '../../../common/images/images.dart';
import '../../../common/translate/strings.dart';
import 'forget_password_controller.dart';


class ForgetPassword extends StatefulWidget {

  const ForgetPassword({super.key});
  @override
  ForgetPasswordState createState() => ForgetPasswordState();
}

class ForgetPasswordState extends StateMVC<ForgetPassword> {
  ForgetPasswordState() : super(ForgetPasswordController()) {
    con = ForgetPasswordController();
  }
  late ForgetPasswordController con;
  final FocusNode idForgetFocusNode = FocusNode();
  bool activeBottomNew=false;
  bool isFocus1=false;
  bool check=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idForgetFocusNode.addListener((){setState(() {
      isFocus1=idForgetFocusNode.hasFocus;
    });});
    con.idController.addListener((){
      setState(() {
        if(con.idController.text.length==10)
        {
          activeBottomNew=true;
        }
        else{activeBottomNew=false;}
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(Images.logoWithoutBackground),
            buildTextField(Icons.contact_mail_outlined, Strings.iqamaNumber.tr(context), false,TextInputType.number,isFocus1?ThemeModel.mainColor:ThemeModel.of(context).greyFontColor, con.idController,10,idForgetFocusNode,context, ),
              con.loading?Center(
                  child: SpinKitWave(color: Colors.grey.shade600, size: 25.0)):
              bottom(Strings.checkAboutUser.tr(context), activeBottomNew? (){setState(() {check=false;});con.sendCode(context);}: null,)
          ],),
        ),
      ),
    );
  }
}
