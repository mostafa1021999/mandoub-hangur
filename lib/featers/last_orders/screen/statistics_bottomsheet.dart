import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:untitled2/common/translate/app_local.dart';
import 'package:untitled2/cubit/rider_cubit.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/components.dart';
import '../../../common/constants/constanat.dart';
import '../../../common/translate/strings.dart';
import '../controller/order_brief_controller.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  CustomBottomSheetState createState() => CustomBottomSheetState();
}

class CustomBottomSheetState extends StateMVC<CustomBottomSheet> {
  CustomBottomSheetState() : super(OrderBriefController()) {
    con = OrderBriefController();
  }
  late OrderBriefController con;
  bool containerPadding=true;
  @override
  void initState() {
    super.initState();
  }
  void startAnimation() {
    setState(() {
      containerPadding =false;
    });
  }
  @override
  Widget build(BuildContext context) {
    List<String> listUnavailableItems =[ Strings.dayStatistics.tr(context),Strings.monthStatistics.tr(context)];
    return SizedBox(
      height: 250,
      child: Column(
        children: [
          const SizedBox(height: 10,),
          Container(
              child: Center(
                  child: Wrap(children: <Widget>[
                    Container(
                        width: 75,
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        height: 5,
                        decoration: const BoxDecoration(
                          color: Colors.black45,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        )),
                  ]))),
          const SizedBox(height: 10,),
          SizedBox(
            height: 100,
            child: ListView.builder(
              physics:const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context,index)=> ListTile(
                leading: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: !containerPadding&&_isCheckedList[index]==true?ThemeModel.mainColor:null,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1.2,color: _isCheckedList[index]==true?ThemeModel.mainColor:Colors.black)),
                    child: CircleAvatar(
                      radius:5,
                      backgroundColor: _isCheckedList[index]==true? ThemeModel.mainColor: Colors.black,
                    ),
                  ),
                ),
                title: Text(listUnavailableItems[index],style:const TextStyle(fontSize: 16,fontWeight:
                FontWeight.w500),),
                onTap: (){
                  setState((){
                    if(index==1){_isCheckedList=[false,true];choose=true;}
                    else{_isCheckedList=[true,false];choose=false;}
                    RiderCubit.get(context).reload();
                  });
                  setState(() {
                    containerPadding =false;
                  });
                  Timer(const Duration(milliseconds: 350), () {
                    setState(() {
                      containerPadding = true;
                    });});
                },
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 15.0,right: 15),
            child: bottom(
              Strings.save.tr(context),
               () {
                 con.navigateStatistics(context,choose);
                 Navigator.pop(context);
               },
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
bool choose=false;
List<bool> _isCheckedList =[ true,false];