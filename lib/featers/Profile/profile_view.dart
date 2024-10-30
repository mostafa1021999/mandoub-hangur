import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:untitled2/Utilities/shared_preferences.dart';
import 'package:untitled2/common/translate/app_local.dart';
import 'package:untitled2/cubit/rider_cubit.dart';

import '../../common/colors/theme_model.dart';
import '../../common/components.dart';
import '../../common/constants/constanat.dart';
import '../../common/translate/strings.dart';
import '../../shared_prefrence/shared prefrence.dart';
import '../auth/Login/login.dart';
import '../chat/chat.dart';
import 'navigators/UserData/user_data_view.dart';
import 'navigators/setting.dart';
import 'navigators/support.dart';
import 'profile_controller.dart';

class ProfileView extends StatefulWidget {
  // static String routeName = ScreenRoutes.login.name;
  const ProfileView({
    super.key,
  });

  @override
  createState() => _ProfileViewState();
}

class _ProfileViewState extends StateMVC<ProfileView> {
  _ProfileViewState() : super(ProfileController()) {
    con = ProfileController();
  }
  late ProfileController con;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RiderCubit, MandoubState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Directionality(
                textDirection: language == 'English Language'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                        color: ThemeModel.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        ProfileListItem(
                          icon: Icons.person_outline,
                          text: Strings.myInformation.tr(context),
                          hasNavigation: true,
                          onTap: () {
                            navigate(context, const UserData());
                          },
                        ),
                        ProfileListItem(
                          icon: Icons.help_outline,
                          text: Strings.helpSupport.tr(context),
                          hasNavigation: true,
                          onTap: () {
                            navigate(context, const Support());
                          },
                        ),
                        if (SharedPref.getToken() != null)
                          ProfileListItem(
                            icon: Icons.headset_mic_outlined,
                            text: Strings.callCenter.tr(context),
                            hasNavigation: true,
                            onTap: () {
                              navigate(context, const Chat());
                            },
                          ),
                        ProfileListItem(
                            icon: Icons.settings_outlined,
                            text: Strings.language.tr(context),
                            hasNavigation: true,
                            onTap: () {
                              navigate(context, const Setting());
                            }),
                        ProfileListItem(
                          icon: Icons.login,
                          text: Strings.logout.tr(context),
                          hasNavigation: false,
                          onTap: () {
                            token = null;
                            Save.remove(key: 'token');
                            navigateAndFinish(context, LoginScreen());
                          },
                        ),
                      ],
                    ),
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

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  final VoidCallback? onTap;
  const ProfileListItem({
    super.key,
    required this.icon,
    required this.text,
    required this.hasNavigation,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ).copyWith(),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Icon(
                  icon,
                  size: 20,
                ),
                const SizedBox(width: 15),
                Text(
                  text,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 15),
                ),
                const Spacer(),
                if (hasNavigation)
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 20,
                    color: ThemeModel.mainColor,
                  ),
              ],
            ),
            if (text != Strings.logout.tr(context))
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
                child: Container(
                    decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: ThemeModel.of(context).greyFontColor,
                      width: 0.8,
                    ),
                  ),
                  color: Colors.orangeAccent,
                )),
              )
          ],
        ),
      ),
    );
  }
}
