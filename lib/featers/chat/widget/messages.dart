import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:untitled2/Utilities/extensions.dart';

import '../../../../../common/colors/theme_model.dart';
import '../../../Utilities/FilesHandler/audio_player_widget.dart';
import '../../../Utilities/helper_functions.dart';
import '../../../common/constants/constanat.dart';
import '../../../model/chat_model.dart';
import '../chat.dart';

Widget messages({ChatModel? chatModel}) {
  chatModel = ChatModel(
    id: chatModel?.id,
    messages: chatModel?.messages?.reversed.toList(),
  );
  return ListView.builder(
    shrinkWrap: true,
    reverse: true,
    physics: const BouncingScrollPhysics(),
    itemCount: chatModel?.messages?.length ?? 0,
    // reverse: true,
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    itemBuilder: (context, index) {
      var messageEnd = (chatModel?.messages?.length ?? 0) - 1 - index;
      // Get the current message's date
      DateTime currentMessageDate =
          DateTime.parse('${chatModel?.messages![messageEnd].createdAt}');
      bool showDate = false;
      if (index == (chatModel?.messages!.length ?? 0) - 1) {
        showDate = true; // Show date for the first message
      } else {
        DateTime previousMessageDate = DateTime.parse(
            '${chatModel?.messages![messageEnd == 0 ? 0 : messageEnd - 1].createdAt}');
        showDate = currentMessageDate.day != previousMessageDate.day ||
            currentMessageDate.month != previousMessageDate.month ||
            currentMessageDate.year != previousMessageDate.year;
      }
      return Column(
        children: [
          if (showDate)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                DateFormat('MMM dd, yyyy').format(currentMessageDate),
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          Container(
            padding:
                const EdgeInsets.only(left: 7, right: 7, top: 7, bottom: 7),
            child: Align(
                alignment: ((chatModel?.messages![messageEnd].from == null)
                    ? Alignment.topLeft
                    : Alignment.topRight),
                child: Column(
                  crossAxisAlignment:
                      chatModel?.messages![messageEnd].from == null
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatTime(
                          '${chatModel?.messages![messageEnd].createdAt}'),
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w400),
                    ),
                    chatModel?.messages![messageEnd].audioUrl != null
                        ? AudioPlayerWidget(
                            audioUrl:
                                chatModel?.messages![messageEnd].audioUrl ?? "",
                          )
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ((chatModel?.messages![messageEnd].from ==
                                      null)
                                  ? ThemeModel.of(context).cardsColor
                                  : ThemeModel.mainColor),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (chatModel?.messages![messageEnd].imageUrls
                                        .isNotEmpty ??
                                    false) ...[
                                  Wrap(
                                    spacing: 10.w,
                                    runSpacing: 10.h,
                                    children: chatModel
                                            ?.messages![messageEnd].imageUrls
                                            .map((url) => InkWell(
                                                  onTap: () {
                                                    HelperFunctions
                                                        .imagePreviewDialog(
                                                            context,
                                                            imagePath: url);
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: Image.network(
                                                      url,
                                                      height: 120.r,
                                                      width: 120.r,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ))
                                            .toList() ??
                                        [],
                                  ),
                                  20.h.heightBox,
                                ],
                                Text(
                                  '${chatModel?.messages?[messageEnd].content}',
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: isDark ?? false
                                          ? Colors.white
                                          : chatModel?.messages![messageEnd]
                                                      .from ==
                                                  null
                                              ? Colors.black
                                              : Colors.white),
                                ),
                              ],
                            )),
                  ],
                )),
          ),
        ],
      );
    },
  ).expand;
}
