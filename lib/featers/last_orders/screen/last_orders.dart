import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:untitled2/common/constants/constanat.dart';
import 'package:untitled2/common/translate/app_local.dart';
import 'package:untitled2/common/translate/strings.dart';
import 'package:untitled2/cubit/rider_cubit.dart';
import 'package:untitled2/featers/last_orders/controller/order_brief_controller.dart';
import '../../../common/colors/theme_model.dart';

class LastOrder extends StatefulWidget {
  const LastOrder({super.key});

  @override
  LastOrderState createState() => LastOrderState();
}

class LastOrderState extends StateMVC<LastOrder> {
  LastOrderState() : super(OrderBriefController()) {
    con = OrderBriefController();
  }
  late OrderBriefController con;
@override
  void initState() {
  String startDate = '${con.currentDate.toIso8601String().split('T')[0]}T00:00:00.000Z';
  String endDate = con.currentDate.add(const Duration(days: 1)).toIso8601String();
  con.getRiderStatistics(context,startDate, endDate);

  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RiderCubit, MandoubState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    List deliveryIcons=[Icons.card_travel,Icons.access_time,Icons.monetization_on_outlined];
    List deliveryNames=[Strings.order.tr(context),Strings.attendance.tr(context),Strings.cash.tr(context)];
    List<List> insideData=[[Strings.totalOrders.tr(context),Strings.rejectedOrders.tr(context),],[Strings.workingHours.tr(context),],[Strings.totalCashCollected.tr(context)]];
    List<List> typeData=[[Strings.order.tr(context),Strings.order.tr(context),'',],[Strings.hours.tr(context),],[Strings.sar.tr(context)]];
    List<List> cardData=[[con.riderStatistics?.totalDeliveredOrders??'0',con.riderStatistics?.totalRejectedOrders??'0',],['${con.riderStatistics?.workingHours?.hours??0}: ${con.riderStatistics?.workingHours?.minutes??0}',],[con.riderStatistics?.totalEarnings??'0']];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0,bottom: 10),
        child: ListView(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(Strings.performance.tr(context),style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 23),),
              InkWell(
                onTap:(){con.goSpacificDay(context);},
                child: Container(
                    padding:const EdgeInsets.all(5),
                    decoration: BoxDecoration(color: ThemeModel.mainColor.withOpacity(0.7),borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        const Icon(Icons.date_range_outlined,color: Colors.white,),
                        const SizedBox(width: 5,),
                        Text(con.viewStatistics=='months'?Strings.month.tr(context):Strings.day.tr(context),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),)
                      ],
                    )),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon:const Icon(Icons.arrow_back_ios_sharp),
                onPressed: (){
                  if(con.viewStatistics=='months'){
                  con.goBackOneMonth(context);}else{
                    con.goBackOneDay(context);
                  }
                  },
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey.shade300,borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      con.viewStatistics=='months'? DateFormat('MMMM yyyy',language).format(con.currentDate,):DateFormat('MMMM d, yyyy',language).format(con.currentDate,),
                      style:const TextStyle(fontSize: 19.0,fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed:(){
                  if(con.viewStatistics=='months'){
                    con.goForwardOneMonth(context);}else{
                    con.goForwardOneDay(context);
                  }},
                icon:const Icon(Icons.arrow_forward_ios,
              ),)
            ],
          ),
          Center(child: Text('${Strings.dayStarts.tr(context)} 6:00 am',style: TextStyle(color: ThemeModel.of(context).greyFontColor,fontWeight: FontWeight.w500),)),
          const SizedBox(height: 15.0),
          con.loading?const Padding(padding: EdgeInsets.only(top: 200.0),child: Center(child: CircularProgressIndicator()),):ListView.builder(
            shrinkWrap: true,
              itemCount: deliveryNames.length,
              itemBuilder: (context,index)=>Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  topData(deliveryNames[index],deliveryIcons[index],context),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                  childAspectRatio: 1/0.5,
                  children: List.generate(insideData[index].length, (indexNew) {
                  return deliveryMandoube(insideData[index][indexNew],typeData[index][indexNew],cardData[index][indexNew],context);
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
Widget topData(topName,topIcon,context)=>Padding(
  padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
  child: Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(color:ThemeModel.mainColor.withOpacity(0.7),borderRadius:language=='en'? BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20))
        :BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [Icon(topIcon,color: Colors.white,),
    const SizedBox(width: 10,),Text('$topName',style: TextStyle(color:Colors.white,fontWeight: FontWeight.w500,fontSize: 20),),
    ],),
  ),
);
Widget deliveryMandoube(nameCard,String type,cardData,context)=>Card(
  color: ThemeModel.of(context).cardColor,
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('$nameCard',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
      Row(children: [ Text('$cardData',style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),),
        const SizedBox(width: 5,),
        Text(type,style: TextStyle(color: ThemeModel.of(context).greyFontColor,fontWeight: FontWeight.w500),),
      ],)
    ],),
  ),);