import 'dart:async';

import 'package:chat_socket/SocketIOChat/chat_message_model.dart';
import 'package:chat_socket/SocketIOChat/chat_title.dart';
import 'package:chat_socket/SocketIOChat/global.dart';
import 'package:chat_socket/SocketIOChat/socket_utils.dart';
import 'package:chat_socket/SocketIOChat/user.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen() : super();
  static const String Route_ID = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessageModel> _chatMessages;
  User _toChatUser;
  UserOnlineStatus _userOnlineStatus;
  TextEditingController _chatTextController;
  ScrollController _chatListController;

  @override
  void dispose() {
    super.dispose();
    _removeListeners();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    _chatMessages = List();
    _chatTextController = TextEditingController();
    _chatListController = ScrollController(initialScrollOffset: 0);
    _toChatUser = G.toChatUser;
    _userOnlineStatus = UserOnlineStatus.connecting;
    _initSocketListener();
    _checkOnline();
    _chatListScrollToBottom();
  }

  _initSocketListener() async {
    G.socketUtils.setOnChatMessageReceiveListener(onChatMessageReceived);
    G.socketUtils.setOnlineUserStatusListener(onUserStatus);
  }

  _removeListeners() async {
    G.socketUtils.setOnChatMessageReceiveListener(null);
    G.socketUtils.setOnlineUserStatusListener(null);
  }

  onUserStatus(data) {
    print('onUserStatus $data');
    ChatMessageModel chatMessageModel = ChatMessageModel.fromJson(data);
    setState(() {
      _userOnlineStatus = chatMessageModel.toUserOnlineStatus
          ? UserOnlineStatus.online
          : UserOnlineStatus.offline;
    });
  }

  _checkOnline() {
    ChatMessageModel chatMessageModel = ChatMessageModel(
      chatId: 0,
      to: _toChatUser.id,
      from: G.loggedInUser.id,
      toUserOnlineStatus: false,
      message: '',
      chatType: SocketUtils.SINGLE_CHAT,
    );
    G.socketUtils.checkOnline(chatMessageModel);
  }

  onChatMessageReceived(data) {
    print('onChatMessageReceived $data');
    ChatMessageModel chatMessageModel = ChatMessageModel.fromJson(data);
    chatMessageModel.isFromMe = false;
    processMessage(chatMessageModel);
  }

  processMessage(chatMessageModel) {
    setState(() {
      _chatMessages.add(chatMessageModel);
    });
  }

  _chatListScrollToBottom() {
    Timer(Duration(milliseconds: 100), () {
      if (_chatListController.hasClients) {
        _chatListController.animateTo(
          _chatListController.position.maxScrollExtent,
          duration: Duration(milliseconds: 100),
          curve: Curves.decelerate,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ChatTitle(
          toChatUser: _toChatUser,
          userOnlineStatus: _userOnlineStatus,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                controller: _chatListController,
                itemCount: _chatMessages.length,
                itemBuilder: (ctx, index) {
                  ChatMessageModel chatMessageModel = _chatMessages[index];
                  bool fromMe = chatMessageModel.isFromMe;
                  return Container(
                    color: fromMe ? Colors.red : Colors.redAccent,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(10),
                    alignment:
                        fromMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Text(chatMessageModel.message),
                  );
                },
              ),
            ),
            _bottomChatArea(),
          ],
        ),
      ),
    );
  }

  _bottomChatArea() {
    return Container(
      // padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          _chatTextArea(),
          IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                _sendMessageBtnTap();
              }),
        ],
      ),
    );
  }

  _sendMessageBtnTap() async {
    print('Sending Message to ${_toChatUser.name}, id: ${_toChatUser.id}');
    if (_chatTextController.text.isEmpty) {
      return;
    }
    ChatMessageModel chatMessageModel = ChatMessageModel(
      chatId: 0,
      to: _toChatUser.id,
      from: G.loggedInUser.id,
      toUserOnlineStatus: false,
      message: _chatTextController.text,
      chatType: SocketUtils.SINGLE_CHAT,
      isFromMe: true,
    );
    processMessage(chatMessageModel);
    G.socketUtils.sendSingleChatMessage(chatMessageModel);
    _chatListScrollToBottom();
  }

  _chatTextArea() {
    return Expanded(
      child: TextField(
        controller: _chatTextController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(10),
          hintText: 'Type Message...',
        ),
      ),
    );
  }
}
