import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:untitled2/featers/chat/controller/chat_data_handler.dart';

import '../../../../../Utilities/FilesHandler/files_cubit.dart';
import '../../../Utilities/shared_preferences.dart';
import '../../../model/chat_model.dart';

class ChatController extends ControllerMVC {
  // singleton
  factory ChatController() {
    _this ??= ChatController._();
    return _this!;
  }

  static ChatController? _this;

  ChatController._();
  @override
  void initState() {
    connectSocket();
    super.initState();
  }

  ChatModel? chatsCallCenter;
  bool loading = false;

  ///   -----------   get chat data   -----------
  Future getChatData() async {
    print("TOKEN   >>>>>> ${SharedPref.getToken()}");
    loading = true;
    setState(() {});
    final result = await ChatDataHandler.getChat();
    result.fold((l) {
      print("error>>>> ${l.errorModel.statusMessage}");
    }, (r) {
      chatsCallCenter = r;
      debugPrint("chatsCallCenter>>>> ${chatsCallCenter?.id}");
    });
    loading = false;
    setState(() {});
  }

  Future sendImages(BuildContext context) async {
    await BlocProvider.of<DragFilesCubit>(context).uploadSelectedImages();
  }

  Future<void> onNewMessage(dynamic message) async {
    if (chatsCallCenter != null && chatsCallCenter!.messages != null) {
      chatsCallCenter!.messages!.add(MessagesModel.fromJson(message));
      setState(() {});
    }
  }

  IO.Socket socket = IO.io(
    'http://delivery.teslm.shop',
    <String, dynamic>{
      'transports': ['websocket', 'polling'],
      'autoConnect': false,
    },
  );

  // ChatModel? chat;

  void connectSocket() {
    socket.connect();

    socket.onConnect((_) {
      debugPrint('Connection established');
      socket.emit("joinChat",
          json.encode({"deliveryPartnerId": SharedPref.getUserID()}));
    });

    socket.on("joinedChat", (data) {
      debugPrint("Joined chat: $data");
      chatsCallCenter = ChatModel.fromJson(data);
      // emit(ReloadChat());
    });

    socket.on('newMessage', (data) {
      print("New Message:>>>>>>>> $data");
      onNewMessage(data);
    });

    socket.onConnectError((data) => debugPrint('Connect Error: $data'));
    socket.onDisconnect((_) => debugPrint('Socket.IO server disconnected'));
  }

  bool isSendMessageNow = false;
  void postMessage(
      {String? message,
      required String chatId,
      required BuildContext context,
      String? audioUrl}) async {
    setState(() {
      isSendMessageNow = true;
    });
    debugPrint(
        "SEND MESSAGE>>>>> Chat id: $chatId   ----   user id: ${SharedPref.getUserID()}");
    if (audioUrl != null) {
      String messageBody = json.encode({
        'chatId': chatId,
        'from': '${SharedPref.getUserID()}',
        // 'content': message,
        'audioUrl': audioUrl
      });
      socket.emit("sendMessage", messageBody);
      debugPrint("SEND AUDIO MESSAGE Done $messageBody");
      setState(() {
        isSendMessageNow = false;
      });
      return;
    }
    if (imagesProvider(context).isNotEmpty) {
      await sendImages(context).then((e) {
        String messageBody = json.encode({
          'chatId': chatId,
          'from': '${SharedPref.getUserID()}',
          'content': message,
          'audioUrl': '',
          'imageUrls': BlocProvider.of<DragFilesCubit>(context)
              .imageUrls
              .map((e) => e.toString())
              .toList()
        });
        debugPrint(
            ">>>>>>>>>>>>>>>>>>>>>>>> ${BlocProvider.of<DragFilesCubit>(context).imageUrls}");
        socket.emit("sendMessage", messageBody);
        BlocProvider.of<DragFilesCubit>(context).clearUrls();
        setState(() {
          isSendMessageNow = false;
        });
        return;
      });
    } else {
      String messageBody = json.encode({
        'chatId': chatId,
        'from': '${SharedPref.getUserID()}',
        'content': message,
      });
      if (message == null) return;
      socket.emit("sendMessage", messageBody);
      setState(() {
        isSendMessageNow = false;
      });
    }

    debugPrint("SEND MESSAGE Done");
  }
}
