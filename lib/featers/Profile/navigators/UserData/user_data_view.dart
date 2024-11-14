import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:untitled2/common/translate/app_local.dart';
import 'package:untitled2/common/translate/strings.dart';

import '../../../../common/colors/theme_model.dart';
import '../../../../common/constants/constanat.dart';
import 'user_data_controller.dart';

class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  createState() => _UserDataState();
}

class _UserDataState extends StateMVC<UserData> {
  _UserDataState() : super(UserDataController()) {
    con = UserDataController();
  }
  late UserDataController con;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      con.getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Strings.myInformation.tr(context)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: con.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    profile(
                        Strings.myPhoneNumber.tr(context),
                        TextEditingController(
                          text: con.userData?.phoneNumber ?? "",
                        ),
                        Icons.phone,
                        context),
                    profile(
                        Strings.myName.tr(context),
                        TextEditingController(
                          text: con.userData?.name ?? "",
                        ),
                        Icons.person,
                        context),
                    profile(
                        Strings.myId.tr(context),
                        TextEditingController(
                          text: con.userData?.residencyNumber ?? "",
                        ),
                        Icons.contact_mail_outlined,
                        context),
                    profile(
                        Strings.licence.tr(context),
                        TextEditingController(
                          text: con.userData?.licenseNumber ?? "",
                        ),
                        Icons.bluetooth_drive_outlined,
                        context),
                    profile(
                        Strings.zoneWork.tr(context),
                        TextEditingController(
                          text: con.userData?.area?.name ?? "",
                        ),
                        Icons.phone,
                        context),
                    profile(
                        Strings.company.tr(context),
                        TextEditingController(
                          text: language == 'en'
                              ? con.userData?.company?.name?.en ?? ""
                              : '${con.userData?.company?.name?.ar}',
                        ),
                        Icons.business_sharp,
                        context),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.rate.tr(context),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        StatefulBuilder(
                          builder: (context, setState) => PannableRatingBar(
                            rate: (con.userData?.totalReviews?.toDouble() ??
                                    0) /
                                (con.userData?.reviewCount?.toDouble() ?? 1),
                            items: List.generate(
                                5,
                                (index) => const RatingWidget(
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
                        Text(
                          Strings.rateCount.tr(context),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        CircleAvatar(
                            backgroundColor: Colors.amber,
                            child: Text(
                              '${con.userData?.reviewCount}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            )),
                      ],
                    ),
                  ],
                ),
        ));
  }
}

Widget profile(text, controller, icon, context, {validate}) => Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Directionality(
        textDirection: language == 'English Language'
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: TextFormField(
          validator: validate,
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            labelText: "$text",
            prefixIcon: Icon(
              icon,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ThemeModel.of(context).textFieldColor),
              borderRadius: const BorderRadius.all(Radius.circular(35.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ThemeModel.of(context).textFieldColor),
              borderRadius: const BorderRadius.all(Radius.circular(35.0)),
            ),
            labelStyle: TextStyle(
                fontSize: 17,
                color: isDark ?? false ? Colors.white : Colors.black),
            contentPadding: const EdgeInsets.all(10),
          ),
        ),
      ),
    );
