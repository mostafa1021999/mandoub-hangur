import 'package:flutter/material.dart';
import 'package:untitled2/common/translate/app_local.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/components.dart';
import '../../../common/translate/strings.dart';
import 'otp change password.dart';


class ForgetPassword extends StatefulWidget {

  const ForgetPassword({super.key});
  @override
  ForgetPasswordState createState() => ForgetPasswordState();
}

class ForgetPasswordState extends State<ForgetPassword> {
  late TextEditingController idController;
  late TextEditingController phoneController;
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode idForgetFocusNode = FocusNode();
  bool activeBottom=false;
  bool activeBottomNew=false;
  bool isFocus1=false;
  bool isFocus2=false;
  bool check=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idController=TextEditingController();
    phoneController=TextEditingController();
    idForgetFocusNode.addListener((){setState(() {
      isFocus1=idForgetFocusNode.hasFocus;
    });});
    phoneFocusNode.addListener((){setState(() {
      isFocus2=phoneFocusNode.hasFocus;
    });});
    idController.addListener((){
      setState(() {
        if(idController.text.length==10)
        {
          activeBottomNew=true;
        }
        else{activeBottomNew=false;}
      });
      phoneController.addListener((){setState((){if(phoneController.text.length>=8){activeBottom=true;}else{activeBottom=false;}});});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 250,
          padding:const EdgeInsets.all(20),
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                buildTextField(Icons.contact_mail_outlined, Strings.iqamaNumber.tr(context), false,TextInputType.number,isFocus1?ThemeModel.mainColor:ThemeModel.of(context).greyFontColor, idController,10,idForgetFocusNode,context, ),
                buildTextField(Icons.phone_android, Strings.enterPhoneNumber.tr(context), false, TextInputType.number,isFocus2?ThemeModel.mainColor:ThemeModel.of(context).greyFontColor,phoneController,10,phoneFocusNode,context,),
                const Spacer(),
                bottom(Strings.checkAboutUser.tr(context), activeBottom&&activeBottomNew? (){setState(() {check=false;});navigateAndFinish(context, OtpNumber(phoneNumber: phoneController.text, country: "966"));}: null,)
              ],),
            ),
          ),
        ),
      ),
    );
  }
}
