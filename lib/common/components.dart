import 'package:flutter/material.dart';
import 'package:untitled2/common/translate/app_local.dart';
import 'package:untitled2/common/translate/strings.dart';
import 'package:untitled2/cubit/rider_cubit.dart';

import 'colors/theme_model.dart';
final now = DateTime.now();
final monthName = _getMonthName(now.month);
final dayOfWeek = _getDayOfWeek(now.weekday);
final dayOfMonth = now.day.toString().padLeft(2, '0');
Widget seperate() =>Padding(
  padding: const EdgeInsets.only(top: 6.0,bottom: 0.6),
  child: Container(decoration: BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: Colors.grey,
        width: 0.8,
      ),
    ),
    color: Colors.orangeAccent,
  )),
);
String _getMonthName(int month) {
  final monthNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  return monthNames[month - 1];
}

String _getDayOfWeek(int weekday) {
  final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  return dayNames[weekday - 1];
}
Widget date(context)=>  Container(
  height: 97,padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
  decoration: BoxDecoration(color: ThemeModel.mainColor,borderRadius: BorderRadius.circular(8)),
  child: Column(children: [
    Text(
      monthName,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w700,color: Colors.red
      ),
    ),
    Text(
      dayOfMonth,
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    Text(
      dayOfWeek,
      style: TextStyle(
        color: ThemeModel.of(context).greyFontColor,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  ],),
);
Widget smallBottom(text)=>Container(
  decoration: BoxDecoration( color: Colors.grey.shade300, borderRadius: BorderRadius.circular(6)),
  padding: EdgeInsets.all(5),
  child: Text(text,style: TextStyle(color: Colors.black,fontSize: 17),),);
navigate( context,screen) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => screen));
}
void navigateAndFinish(context , Widget) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Widget), (route) => false);
Widget bottom(data,onTap,){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(disabledBackgroundColor: ThemeModel.mainColor.withOpacity(0.6),backgroundColor: ThemeModel.mainColor),
    onPressed: onTap,
    child: Center(child:Text(data  , style: TextStyle( fontWeight: FontWeight.bold , fontSize: 25,color: Colors.white))));}

Widget orderDesign(restaurant,distance,time,name,locationName,context)=>Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Container(
      width: MediaQuery.sizeOf(context).width/1.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Text('$distance-$time',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: ThemeModel.of(context).brownColor),),
              const Spacer(),
              Text(name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: ThemeModel.of(context).brownColor),),
            ],
          ),
          Text(locationName,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: ThemeModel.of(context).brownColor),maxLines: 1,overflow: TextOverflow.ellipsis,),
        ],
      ),
    ),
    SizedBox(width: 10,),
    Column(
      children: [
        Icon(restaurant?Icons.shop:Icons.person_pin,color: ThemeModel.of(context).brownColor,),
        SizedBox(height: 5,),
        if(restaurant)
        Container(
          height: 25,
          width: 1.2,
          color: ThemeModel.mainColor,
        )
      ],
    ),
  ],
);
Widget buildTextField(
    IconData icon, String hintText, bool isPassword, type,iconColor,controller,maxLength,focus,context) {
  return StatefulBuilder(
    builder:(context,setState)=> Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        validator: isPassword?(value){
          if (!isPasswordComplex(value!)) {
            return Strings.enterPasswordGreater.tr(context);
          }
          return null;
        }:null,
        focusNode: focus,
        maxLength: maxLength,
        controller: controller,
        obscureText:isPassword? RiderCubit.get(context).showPassword:false,
        keyboardType: type,
        decoration: InputDecoration(
          prefixIconColor: iconColor,
          counterText: '',
          prefixIcon: Icon(
            icon,
            color:focus.hasFocus?ThemeModel.mainColor:ThemeModel.of(context).greyFontColor,
          ),
          suffixIcon:isPassword? IconButton(onPressed: (){
            setState((){isPassword=!isPassword;});
            RiderCubit.get(context).changePassType(RiderCubit.get(context).iconPassword,isPassword);}, icon: Icon(RiderCubit.get(context).iconPassword)):null,
          enabledBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: ThemeModel.of(context).textColor1),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          focusedBorder:const OutlineInputBorder(
            borderSide: BorderSide(color: ThemeModel.mainColor),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          contentPadding: const EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color:ThemeModel.of(context). textColor1),
        ),
      ),
    ),
  );
}
bool isPasswordComplex(String password) {
  // Define the requirements for a complex password
  final hasUppercase = password.contains(RegExp(r'[A-Z]'));
  final hasLowercase = password.contains(RegExp(r'[a-z]'));
  final hasDigit = password.contains(RegExp(r'[0-9]'));
  final hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>-]'));
  final hasMinLength = password.length >= 8;

  // Check if the password meets the complexity requirements
  return hasUppercase && hasLowercase && hasDigit && hasSpecialChar && hasMinLength;
}