import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:untitled2/Utilities/extensions.dart';
import 'package:untitled2/common/translate/app_local.dart';

import '../../common/colors/theme_model.dart';
import '../../common/constants/constanat.dart';
import '../../common/text_style_helper.dart';
import '../../common/translate/strings.dart';
import 'Models/notification_model.dart';
import 'cubit/notifications_cubit.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      NotificationsCubit.get(context).getNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsCubit, NotificationsStates>(
      listener: (context, state) {
        // Handle state changes
      },
      builder: (context, state) {
        final cubit = NotificationsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              Strings.notifications.tr(context),
            ),
          ),
          body: state is NotificationsLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  itemCount: cubit.notifications.length,
                  separatorBuilder: (context, index) => 4.h.heightBox,
                  itemBuilder: (context, index) {
                    return NotificationWidget(
                      notificationModel: cubit.notifications[index],
                    );
                  },
                ).paddingSymmetric(horizontal: 8.w),
        );
      },
    );
  }
}

class NotificationWidget extends StatelessWidget {
  final NotificationModel? notificationModel;
  const NotificationWidget({super.key, this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ThemeModel.of(context).cardsColor,
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              language == 'en'
                  ? (notificationModel?.title?.en ?? "")
                  : (notificationModel?.title?.ar ?? ""),
              style: TextStyleHelper.of(context).medium18),
          16.h.heightBox,
          Row(
            children: [
              Text(
                language == 'en'
                    ? (notificationModel?.body?.en ?? "")
                    : (notificationModel?.body?.ar ?? ""),
                style: TextStyleHelper.of(context)
                    .regular16
                    .copyWith(color: ThemeModel.of(context).font2),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ).expand,
            ],
          ),
          32.h.heightBox,
          Text(
            notificationModel?.createdAt == null
                ? ""
                : DateFormat(
                        'MMMM d, yyyy h:mm a', language == 'en' ? "en" : "ar")
                    .format(notificationModel!.createdAt!),
            style: TextStyleHelper.of(context)
                .regular16
                .copyWith(color: ThemeModel.of(context).font2),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ).align(AlignmentDirectional.bottomEnd),
        ],
      ).paddingSymmetric(vertical: 16, horizontal: 16.w),
    );
  }
}
