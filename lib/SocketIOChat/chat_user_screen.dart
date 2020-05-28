import 'package:chat_socket/SocketIOChat/chat_screen.dart';
import 'package:chat_socket/SocketIOChat/global.dart';
import 'package:chat_socket/SocketIOChat/user.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class ChatUserScreen extends StatefulWidget {
  ChatUserScreen() : super();
  static const String Route_ID = 'chat_user_screen';
  @override
  _ChatUserScreenState createState() => _ChatUserScreenState();
}

class _ChatUserScreenState extends State<ChatUserScreen> {
  List<User> _chatUsers;
  bool _connectedToSocket;
  String _connectMessage;

  @override
  void initState() {
    super.initState();
    _chatUsers = G.getUsersFor(G.loggedInUser);
    _connectedToSocket = false;
    _connectMessage = 'Connecting...';
    _connectToSocket();
  }

  _connectToSocket() async {
    print(
        'Connecting Logged In User ${G.loggedInUser.name},${G.loggedInUser.id}');
    G.initSocket();
    await G.socketUtils.initsocket(G.loggedInUser);
    G.socketUtils.connectToSocket();
    G.socketUtils.setOnConnectListener(onConnect);
    G.socketUtils.setOnConnectionErrorListener(onConnectionError);
    G.socketUtils.setOnConnectionErrorTimeOutListener(onConnectionTimeOut);
    G.socketUtils.setOnDissconnectListener(onDisconnect);
    G.socketUtils.setOnErrorListener(onError);
  }

  onConnect(data) {
    setState(() {
      print('onConnect $data');
      _connectedToSocket = true;
      _connectMessage = 'Connected';
    });
  }

  onConnectionError(data) {
    setState(() {
      print('onConnectionError $data');
      _connectedToSocket = false;
      _connectMessage = 'Connection Error';
    });
  }

  onConnectionTimeOut(data) {
    setState(() {
      print('onConnectionTimeOut $data');
      _connectedToSocket = false;
      _connectMessage = 'Connection Timed Out';
    });
  }

  onError(data) {
    setState(() {
      print('onError $data');
      _connectedToSocket = false;
      _connectMessage = 'Connection Error';
    });
  }

  onDisconnect(data) {
    setState(() {
      print('onDisconnect $data');
      _connectedToSocket = false;
      _connectMessage = 'Disconnected';
    });
  }

  _openLoginScreen(context) async {
    await Navigator.pushReplacementNamed(context, LoginScreen.Route_ID);
  }

  _openChatScreen(context) async {
    await Navigator.pushNamed(context, ChatScreen.Route_ID);
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
              G.socketUtils.closeConnection();
              _openLoginScreen(context);
            },
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Text(_connectedToSocket ? 'Connected' : _connectMessage),
            Expanded(
              child: ListView.builder(
                itemCount: _chatUsers.length,
                itemBuilder: (ctx, index) {
                  User user = _chatUsers[index];
                  return ListTile(
                    onTap: () {
                      G.toChatUser = user;
                      _openChatScreen(context);
                    },
                    title: Text(user.name),
                    subtitle: Text('ID ${user.id}, Email: ${user.email}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
