import 'package:chat_socket/SocketIOChat/chat_message_model.dart';
import 'package:chat_socket/SocketIOChat/chat_title.dart';
import 'package:chat_socket/SocketIOChat/global.dart';
import 'package:chat_socket/SocketIOChat/user.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

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
  @override
  void initState() {
    super.initState();
    _chatMessages = List();
    _toChatUser = G.toChatUser;
    _userOnlineStatus = UserOnlineStatus.connecting;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ChatTitle(
            toChatUser: _toChatUser, userOnlineStatus: _userOnlineStatus),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _chatMessages.length,
                itemBuilder: (ctx, index) {
                  ChatMessageModel chatMessageModel = _chatMessages[index];
                  return Text(chatMessageModel.message);
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
          IconButton(icon: Icon(Icons.send), onPressed: () {}),
        ],
      ),
    );
  }

  _chatTextArea() {
    return Expanded(
      child: TextField(
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
