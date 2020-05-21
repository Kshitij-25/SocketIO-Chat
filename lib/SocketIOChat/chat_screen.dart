import 'package:chat_socket/SocketIOChat/chat_message_model.dart';
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
  @override
  void initState() {
    super.initState();
    
  }

  _openLoginScreen(context) async {
    await Navigator.pushReplacementNamed(context, LoginScreen.Route_ID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _openLoginScreen(context);
            },
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
