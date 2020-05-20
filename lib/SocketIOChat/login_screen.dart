import 'package:chat_socket/SocketIOChat/chat_user_screen.dart';
import 'package:chat_socket/SocketIOChat/global.dart';
import 'package:chat_socket/SocketIOChat/user.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen() : super();
  static const String Route_ID = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController;
  @override
  void initState() {
    _usernameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lets Chat'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(20),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            OutlineButton(
              onPressed: () {
                _loginBtnTap();
              },
              child: Text('LOGIN'),
            )
          ],
        ),
      ),
    );
  }

  _loginBtnTap() {
    if (_usernameController.text.isEmpty) {
      return;
    }
    User me = G.dummyUsers[0];
    if (_usernameController.text != 'a') {
      me = G.dummyUsers[1];
    }
    G.loggedInUser = me;
    _openChatUserListScreen(context);
  }

  _openChatUserListScreen(context) async {
    await Navigator.pushReplacementNamed(context, ChatUserScreen.Route_ID);
  }
}
