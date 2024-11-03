import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:untitled2/Utilities/extensions.dart';
import 'package:untitled2/featers/chat/widget/messages.dart';

import '../../common/components.dart';
import '../../common/images/images.dart';
import '../../common/translate/app_local.dart';
import '../../common/translate/strings.dart';
import 'controller/chat_controller_cubit.dart';
import 'widget/send_message_part.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  createState() => _ChatState();
}

class _ChatState extends StateMVC<Chat> {
  _ChatState() : super(ChatController()) {
    con = ChatController();
  }
  late ChatController con;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      con.getChatData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: appBarWithIcons(Strings.callCenter.tr(context),
              Images.callCenterImage, true, context)),
      body: con.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // const AudioPlayerWidget(
                //   audioUrl:
                //       "https://res.cloudinary.com/dmzdzq3ug/video/upload/v1729447467/x1cxgwq3o4v20nxa0s6v.mp3",
                // ),
                messages(chatModel: con.chatsCallCenter),
                20.h.heightBox,
                SendMessagePart(
                  chatId: con.chatsCallCenter?.id?.toString(),
                  isSendMessageNow: con.isSendMessageNow,
                )
              ],
            ),
    );
  }

  late final File selectedImages;

  Future pickImageFromGallery(context) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    selectedImages = File(returnedImage.path);
    // ChatControllerCubit.get(context).increment();
  }

  Future pickImageFromCamera(context) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    selectedImages = File(returnedImage.path);
    // ChatControllerCubit.get(context).increment();
  }
}

String formatTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  int hour = dateTime.hour;
  int minute = dateTime.minute;

  String period = hour >= 12 ? 'PM' : 'AM';
  hour = hour % 12; // Convert to 12-hour format
  hour = hour == 0 ? 12 : hour; // Adjust hour for 12 AM

  return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
}
