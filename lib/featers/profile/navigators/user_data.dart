import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:untitled2/common/translate/app_local.dart';
import 'package:untitled2/common/translate/strings.dart';
import 'package:untitled2/cubit/rider_cubit.dart';

import '../../../common/colors/theme_model.dart';
import '../../../common/constants/constanat.dart';

class UserData extends StatelessWidget {
  const UserData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RiderCubit, MandoubState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var rider=RiderCubit.get(context).getData;
    double rate=rider!.totalReviews!.toDouble()/rider.reviewCount!.toDouble();
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.editInformation.tr(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child:rider!=null? Column(
          children: [
            const SizedBox(height: 15,),
            profile(Strings.myPhoneNumber.tr(context),TextEditingController(text: '${rider.phoneNumber}',),Icons.phone,context),
            profile(Strings.myName.tr(context),TextEditingController(text: '${rider.name}',),Icons.person,context),
            profile(Strings.myId.tr(context),TextEditingController(text:'${rider.residencyNumber}',),Icons.contact_mail_outlined,context),
            profile(Strings.licence.tr(context),TextEditingController(text:'${rider.licenseNumber}',),Icons.bluetooth_drive_outlined,context),
            profile(Strings.company.tr(context),TextEditingController(text:language=='en'?'${rider.company!.name!.en}':'${rider.company!.name!.ar}',),Icons.business_sharp,context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.rate.tr(context),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                StatefulBuilder(
                  builder:(context,setState)=> PannableRatingBar(
                    rate: rate,
                    items: List.generate(5, (index) =>
                    const RatingWidget(
                      selectedColor: Colors.amber,
                      unSelectedColor: Colors.grey,
                      child: Icon(
                        Icons.star,
                        size: 40,
                      ),
                    )),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.rateCount.tr(context),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                CircleAvatar(
                    backgroundColor:Colors.amber,
                    child: Text('${rider.reviewCount}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),)),
              ],
            ),
          ],
        ):const Center(child: CircularProgressIndicator(),),
      )
    );
  },
);
  }
}
Widget profile(text,controller,icon,context,{validate})=>Padding(
  padding: const EdgeInsets.only(bottom: 15.0),
  child: Directionality(
    textDirection: language=='English Language'? TextDirection.ltr:TextDirection.rtl,
    child: TextFormField(
      validator: validate,
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: "$text",
        prefixIcon: Icon(
          icon,
        ),
        enabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: ThemeModel.of(context).textFieldColor),
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeModel.of(context).textFieldColor),
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        labelStyle: TextStyle(fontSize: 17,color:isDark??false? Colors.white:Colors.black),
        contentPadding: const EdgeInsets.all(10),
      ),
    ),
  ),
);

