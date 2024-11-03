import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:untitled2/Utilities/extensions.dart';
import 'package:untitled2/common/translate/app_local.dart';

import '../../../../../Utilities/FilesHandler/files_cubit.dart';
import '../../../../../Utilities/FilesHandler/files_states.dart';
import '../../../../../Utilities/FilesHandler/images_in_board.dart';
import '../../../../../common/colors/theme_model.dart';
import '../../../../../common/translate/strings.dart';
import '../../../common/constants/constanat.dart';
import '../controller/chat_controller_cubit.dart';
import 'select_images_widget.dart';

class SendMessagePart extends StatefulWidget {
  final String? chatId;
  final bool isSendMessageNow;
  const SendMessagePart(
      {super.key, this.chatId, this.isSendMessageNow = false});

  @override
  State<SendMessagePart> createState() => _SendMessagePartState();
}

class _SendMessagePartState extends State<SendMessagePart> {
  @override
  void initState() {
    messageController = TextEditingController();
    super.initState();
  }

  late TextEditingController messageController;

  // final ScrollController _scrollController = ScrollController();
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  void pauseRecording() {
    _audioRecorder.pause();
    setState(() {
      _isRecording = false;
    });
  }

  Future<void> _startRecording() async {
    // Request microphone permission for recording audio
    PermissionStatus microphoneStatus = await Permission.microphone.request();

    // Request storage permission (for Android 11+, MANAGE_EXTERNAL_STORAGE permission is needed)
    PermissionStatus storageStatus = await Permission.storage.request();

    if (microphoneStatus.isGranted && storageStatus.isGranted) {
      {
        final Directory downloadsDir = await getTemporaryDirectory();
        debugPrint('Permission granted>>>>>>>>>>>  ${downloadsDir.path}');
        if (await _audioRecorder.hasPermission()) {
          await _audioRecorder.start(
            const RecordConfig(),
            path:
                "${downloadsDir.path}/recorded_audio${DateTime.now().millisecondsSinceEpoch}.mp3",
          );
          setState(() {
            _isRecording = true;
            isRecordingNow = true;
          });
        } else {
          // Handle permission denied
          debugPrint('Permission denied');
        }
      }
    } else {
      debugPrint('Permissions denied');
      // Handle permission denied case
    }
  }

  Future<void> _stopRecording(BuildContext context) async {
    final path = await _audioRecorder.stop();
    if (path == null || widget.chatId == null) return;
    BlocProvider.of<DragFilesCubit>(context)
        .uploadRecord(path, context, widget.chatId!);
    setState(() {
      _isRecording = false;
      isRecordingNow = false;
    });

    // Do something with the audio file, for example, upload or play
    debugPrint('Recording saved at: $path');
  }

  bool isRecordingNow = false;
  void resumeAndPauseRecording() {
    if (isRecordingNow) {
      _audioRecorder.pause().then(
        (value) {
          setState(() {
            isRecordingNow = false;
          });
        },
      );
    } else {
      _audioRecorder.resume().then(
        (value) {
          setState(() {
            isRecordingNow = true;
            // _isRecording = true;
          });
        },
      );
    }
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    messageController.dispose();
    super.dispose();
  }

  bool langEn = true;
  final RegExp english = RegExp(r'^[a-zA-Z]+');

  @override
  Widget build(BuildContext context) {
    print(">>>>>>>>>>>>>>> ${widget.chatId}");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ///    ---------------   Images in board  ---------------
          const ImagesInBoardWidget(),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ThemeModel.of(context).chatTextField),
            padding: const EdgeInsets.only(left: 10, bottom: 3, top: 3),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (language == 'en')
                  SizedBox(
                    width: 8.w,
                  ),
                _isRecording
                    ? GestureDetector(
                        onTap: () {
                          _audioRecorder.cancel().then(
                            (value) {
                              setState(() {
                                _isRecording = false;
                              });
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: Text(
                            Strings.cancel.tr(context),
                            style: TextStyle(
                                color: ThemeModel.of(context).red,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp),
                          ),
                        ),
                      )
                    : const SelectImagesWidget(),
                8.w.widthBox,
                Expanded(
                    child: _isRecording
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                InkWell(
                                  onTap: resumeAndPauseRecording,
                                  child: Icon(
                                    isRecordingNow
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                  ),
                                )
                              ])
                        : StatefulBuilder(
                            builder: (context, newSetState) => TextFormField(
                                  onChanged: (val) {
                                    setState(() {
                                      if (english.hasMatch(val)) {
                                        langEn = true;
                                      } else {
                                        langEn = false;
                                      }
                                    });
                                  },
                                  minLines: 1,
                                  maxLines: 3,
                                  textDirection: langEn
                                      ? TextDirection.ltr
                                      : TextDirection.rtl,
                                  controller: messageController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          Strings.writeMessage.tr(context),
                                      hintStyle: TextStyle(
                                          color: ThemeModel.of(context).font2)),
                                ))),
                8.w.widthBox,
                BlocConsumer<DragFilesCubit, FilesStates>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: messageController.text.isEmpty &&
                                imagesProvider(context).isEmpty
                            ? InkWell(
                                overlayColor:
                                    WidgetStateProperty.all(Colors.transparent),
                                onTap: () {
                                  _isRecording
                                      ? _stopRecording(context)
                                      : _startRecording();
                                },
                                child: CircleAvatar(
                                  backgroundColor: _isRecording
                                      ? Colors.white
                                      : ThemeModel.mainColor,
                                  radius: 20,
                                  child: BlocProvider.of<DragFilesCubit>(
                                              context)
                                          .startUploadRecord
                                      ? const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Center(
                                              child: CircularProgressIndicator(
                                            color: Colors.white,
                                          )),
                                        )
                                      : _isRecording
                                          ? Image.asset(
                                              "assets/images/recorder.gif",
                                              color: Colors.red,
                                              width: 26,
                                              height: 26,
                                            )
                                          : const Center(
                                              child: Icon(Icons.mic,
                                                  color: Colors.white,
                                                  size: 26),
                                            ),
                                ),
                              )
                            : widget.isSendMessageNow
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: ThemeModel.mainColor,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      if (widget.chatId == null) {
                                        return;
                                      }
                                      ChatController().postMessage(
                                        context: context,
                                        message: messageController.text.trim(),
                                        chatId: widget.chatId!,
                                      );
                                      messageController.clear();
                                    },
                                    child: const CircleAvatar(
                                      radius: 20,
                                      backgroundColor: ThemeModel.mainColor,
                                      child: Icon(Icons.send,
                                          color: Colors.white, size: 26),
                                    ),
                                  ),
                      );
                    }),
                if (language != 'en')
                  SizedBox(
                    width: 8.w,
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
