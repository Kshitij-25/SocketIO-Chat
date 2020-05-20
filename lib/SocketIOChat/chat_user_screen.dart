import 'package:chat_socket/SocketIOChat/global.dart';
import 'package:chat_socket/SocketIOChat/user.dart';
import 'package:flutter/material.dart';

class ChatUserScreen extends StatefulWidget {
  ChatUserScreen() : super();
  static const String Route_ID = 'chat_user_screen';
  @override
  _ChatUserScreenState createState() => _ChatUserScreenState();
}

class _ChatUserScreenState extends State<ChatUserScreen> {
  List<User> _chatUsers;
  @override
  void initState() {
    super.initState();
    _chatUsers = G.getUsersFor(G.loggedInUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(),
      ),
    );
  }
}
