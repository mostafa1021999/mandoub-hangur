import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled2/common/constants/constanat.dart';
import 'package:untitled2/common/translate/app_local.dart';
import 'package:untitled2/common/translate/strings.dart';
import 'package:untitled2/cubit/rider_cubit.dart';
import '../../common/colors/theme_model.dart';

class LastOrder extends StatelessWidget {
  const LastOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RiderCubit, MandoubState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    List deliveryIcons=[Icons.card_travel,Icons.access_time,Icons.monetization_on_outlined];
    List deliveryNames=[Strings.order.tr(context),Strings.attendance.tr(context),Strings.cash.tr(context)];
    List<List> insideData=[[Strings.totalOrders.tr(context),Strings.deliveryRate.tr(context),Strings.totalCheckInTime.tr(context),],[Strings.workingHours.tr(context),],[Strings.totalCashCollected.tr(context)]];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(children: [
          InkWell(
            onTap:(){RiderCubit.get(context).goSpacificDay(context);},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(Strings.performance.tr(context),style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 23),),
                Container(
                    padding:const EdgeInsets.all(5),
                    decoration: BoxDecoration(color: ThemeModel.of(context).greyFontColor.withOpacity(0.3),borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        const Icon(Icons.date_range_outlined),
                        const SizedBox(width: 5,),
                        Text(Strings.day.tr(context))
                      ],
                    ))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon:const Icon(Icons.arrow_back_ios_sharp),
                onPressed: RiderCubit.get(context).goBackOneDay,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey.shade300,borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      DateFormat('MMMM d, yyyy',language).format(RiderCubit.get(context).currentDate,),
                      style:const TextStyle(fontSize: 19.0,fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: RiderCubit.get(context).goForwardOneDay,
                icon:const Icon(Icons.arrow_forward_ios,
              ),)
            ],
          ),
          Center(child: Text('${Strings.dayStarts.tr(context)} 6:00 am',style: TextStyle(color: ThemeModel.of(context).greyFontColor,fontWeight: FontWeight.w500),)),
          const SizedBox(height: 15.0),
          ListView.builder(
            shrinkWrap: true,
              itemCount: deliveryNames.length,
              itemBuilder: (context,index)=>Column(
                children: [
                  topData(deliveryNames[index],deliveryIcons[index],context),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                  childAspectRatio: 1/0.5,
                  children: List.generate(insideData[index].length, (indexNew) {
                  return deliveryMandoube(insideData[index][indexNew],context);
                },
                ))
                ],
              ))
        ],),
      ),
    );
  },
);
  }
}
Widget topData(topName,topIcon,context)=>Row(children: [CircleAvatar(backgroundColor: Colors.grey.shade300,radius: 18, child: Icon(topIcon)),
const SizedBox(width: 5,),Text('$topName',style: TextStyle(color:ThemeModel.of(context).greyFontColor,fontWeight: FontWeight.w500,fontSize: 20),),
],);
Widget deliveryMandoube(nameCard,context)=>Card(
  color: ThemeModel.of(context).cardColor,
  child: Column(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('$nameCard',style: TextStyle(color: ThemeModel.of(context).greyFontColor,fontWeight: FontWeight.w500),),
    Row(children: [const Text('10',style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),),
      const SizedBox(width: 5,),
      Text('order',style: TextStyle(color: ThemeModel.of(context).greyFontColor,fontWeight: FontWeight.w500),),
    ],)
  ],),);