import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/common/translate/app_local.dart';
import 'package:untitled2/cubit/rider_cubit.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/components.dart';
import '../../../common/translate/strings.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});
  @override
  _NewPassword createState() => _NewPassword();
}

class _NewPassword extends State<NewPassword> {
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  final _formKey = GlobalKey<FormState>();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool activeBottom=false;
  bool activeBottomNew=false;
  bool isFocus1=false;
  bool isFocus2=false;
  bool check=false;
  //======================
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordController=TextEditingController();
    confirmPasswordController=TextEditingController();
    passwordFocusNode.addListener((){setState(() {
      isFocus1=passwordFocusNode.hasFocus;
    });});
    confirmPasswordFocusNode.addListener((){setState(() {
      isFocus2=confirmPasswordFocusNode.hasFocus;
    });});
    passwordController.addListener((){
      setState(() {
        if(passwordController.text.length>=8)
        {
          activeBottomNew=true;
        }
        else{activeBottomNew=false;}
      });
      confirmPasswordController.addListener((){setState((){if(confirmPasswordController.text.length>=8){activeBottom=true;}else{activeBottom=false;}});});
    });
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
        child: Container(
          height: 300,
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  buildTextField(Icons.password, Strings.enterNewPassword.tr(context), true,TextInputType.text,isFocus1?ThemeModel.mainColor:ThemeModel.of(context).greyFontColor, passwordController,20,passwordFocusNode,context ),
                  buildTextField(Icons.password, Strings.confirmNewPassword.tr(context), true, TextInputType.text,isFocus2?ThemeModel.mainColor:ThemeModel.of(context).greyFontColor,confirmPasswordController,20,confirmPasswordFocusNode,context),
                  Spacer(),
                  bottom(Strings.changePassword.tr(context), activeBottom&&activeBottomNew? (){
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                    setState(() {check=false;});}: null,)
                ],),
              ),
            ),
          ),
        ),
      ),
    );
  },
);
  }
}
