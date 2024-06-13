import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/componants/colors.dart';
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
Widget date()=>  Container(
  height: 97,padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
  decoration: BoxDecoration(color: mainColor.shade50,borderRadius: BorderRadius.circular(8)),
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
        color: greyFontColor,
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
Widget bottom(data,onTap){
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: mainColor.shade400,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.3),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1))
          ]),
      child: Center(child:  Text(data  , style: TextStyle( fontWeight: FontWeight.bold , fontSize: 25,color: Colors.white))),
    ),
  );
}