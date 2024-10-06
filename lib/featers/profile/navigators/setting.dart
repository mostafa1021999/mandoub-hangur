import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/common/translate/app_local.dart';
import 'package:untitled2/cubit/rider_cubit.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/constants/constanat.dart';
import '../../../common/images/images.dart';
import '../../../common/translate/strings.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RiderCubit, MandoubState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.settings.tr(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(Strings.chooseLanguage.tr(context),
              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                languageAndThem(false,'English',Images.english,language=='en'?Icons.check:null,language=='en'?ThemeModel.mainColor: Colors.transparent,'en',language=='en'?ThemeModel.mainColor:isDark??false?ThemeModel.of(context).greyFontColor:ThemeModel.of(context).greyFontColor,context),
                languageAndThem(false,'عربى',Images.arabic,language!='en'?Icons.check:null,language!='en'?ThemeModel.mainColor: Colors.transparent, 'ar',language!='en'?ThemeModel.mainColor:isDark??false?ThemeModel.of(context).greyFontColor:ThemeModel.of(context).greyFontColor,context),
              ],
            ),
          ],
        ),
      ),
    );
  },
);
  }
}
Widget languageAndThem(them,text,flag,icon,color,onTapLang,textBorderColor,context,)=>SizedBox(
  height: 150,
  width: 150,
  child: InkWell(
    onTap: (){
      RiderCubit.get(context).changeLanguage(lange: onTapLang);
      },
    child: Card(
      color: ThemeModel.of(context).cardColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0,top: 10),
            child: Align( alignment: Alignment.topRight,child: CircleAvatar(backgroundColor:color,radius:10,child: Icon(icon,size: 18,color: Colors.white,))),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: 60,
            height: 50,
            decoration:  BoxDecoration(
              border: Border.all(color: textBorderColor,width: 1),
            ),
            child: them?Icon(flag,color: textBorderColor,):Image.asset(flag),
          ),
          Spacer(),
          Text(text,style: TextStyle(color: textBorderColor,fontWeight: FontWeight.w600),),
          SizedBox(height: 15,)
        ],
      ),
    ),
  ),
);