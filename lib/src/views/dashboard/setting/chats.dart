/*

import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:delapanbelasfx/src/components/action_sheet.dart';
import 'package:delapanbelasfx/src/components/appbars.dart';
import 'package:delapanbelasfx/src/components/main_variable.dart';
import 'package:delapanbelasfx/src/controllers/chats_controller.dart';
import 'package:delapanbelasfx/src/helpers/focus_manager.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';


class ChatPage extends StatefulWidget {
  // final types.Room room;
  const ChatPage({
    super.key, 
    // required this.room
    });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatControllers chatControllers = Get.put(ChatControllers());
  bool? isAttachmentUploading = false;
  List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAttachmentPressed() {
    showCupertinoActionSheet(
      context, 
      cupertinoActionSheet: [
        CupertinoActionSheetAction(
          onPressed: (){
            Navigator.pop(context);
            _handleImageSelection();
          }, 
          child: const Text("Photo")
        ),
        CupertinoActionSheetAction(
          onPressed: (){
            Navigator.pop(context);
            _handleFileSelection();
          }, 
          child: const Text("File")
        ),
    ],
    message: "Choose file",
    title: "File");
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      _setAttachmentUploading(true);
      // final file = File(result.path);
      // final size = file.lengthSync();
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      // final name = result.name;

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index = _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage = (_messages[index] as types.FileMessage).copyWith(isLoading: true);
          // FirebaseChatCore.instance.updateMessage(message, widget.room.id);
          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index = _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage = (_messages[index] as types.FileMessage).copyWith(isLoading: null);
          setState(() {
            _messages[index] = updatedMessage;
          });
          // FirebaseChatCore.instance.updateMessage(message, widget.room.id);
        }
      }
      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });

    // FirebaseChatCore.instance.updateMessage(message, widget.room.id);
  }

  _handleSendPressed(types.PartialText message) async{
    // FirebaseChatCore.instance.sendMessage(message, widget.room.id);
    if(await chatControllers.sendMessage(
      message: message.text
    )){
      final textMessage = types.TextMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: message.text,
      );
      _addMessage(textMessage);
    }
  }

  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/json/contoh_pesan.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = messages;
    });
  }

  void _setAttachmentUploading(bool uploading){
    setState(() {
      isAttachmentUploading = uploading;
    });
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: (){
      focusManager();
    },
    child: Scaffold(
      backgroundColor: GlobalVariablesType.backgroundColor,
      appBar: kDefaultAppBarCustom(context, title: const Text("Help Center"), centerTitle: true, actions: [
        IconButton(
          tooltip: "Refresh",
          onPressed: (){
            chatControllers.getMessages();
          }, 
          icon: const Icon(Icons.refresh)
        )
      ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Chat(
          messages: _messages,
          onAttachmentPressed: _handleAttachmentPressed,
          onMessageTap: _handleMessageTap,
          onPreviewDataFetched: _handlePreviewDataFetched,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: _user,
          theme: DefaultChatTheme(
            inputBorderRadius: BorderRadius.circular(40),
            attachmentButtonIcon: const Icon(CupertinoIcons.paperclip, color: Colors.white70,),
            backgroundColor: GlobalVariablesType.backgroundColor!,
            sendingIcon: const Icon(CupertinoIcons.clock, color: Colors.white,),
            seenIcon: const Icon(Icons.check, color: Colors.white,),
            ),
          ),
      ),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: StreamBuilder<types.Room>(
      //     initialData: widget.room,
      //     stream: FirebaseChatCore.instance.room(widget.room.id),
      //     builder: (context, snapshot) => StreamBuilder<List<types.Message>>(
      //       initialData: [],
      //       stream: FirebaseChatCore.instance.messages(snapshot.data!),
      //       builder: (context, snapshot) => 
      //       Chat(
      //       messages: _messages,
      //       onAttachmentPressed: _handleAttachmentPressed,
      //       onMessageTap: _handleMessageTap,
      //       onPreviewDataFetched: _handlePreviewDataFetched,
      //       onSendPressed: _handleSendPressed,
      //       showUserAvatars: true,
      //       showUserNames: true,
      //       user: types.User(id: FirebaseChatCore.instance.firebaseUser?.uid ?? _user.id),
      //       theme: DefaultChatTheme(
      //         inputBorderRadius: BorderRadius.circular(40),
      //         attachmentButtonIcon: const Icon(CupertinoIcons.paperclip, color: Colors.white70,),
      //         backgroundColor: GlobalVariablesType.backgroundColor!,
      //         seenIcon: const Text(
      //           'read',
      //           style: TextStyle(
      //             fontSize: 10.0,
      //             color: Colors.white
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    ),
  );
}

*/