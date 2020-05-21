import 'package:flutter/material.dart';

import 'user.dart';

enum UserOnlineStatus { connecting, online, offline }

class ChatTitle extends StatelessWidget {
  final User toChatUser;
  final UserOnlineStatus userOnlineStatus;
  const ChatTitle({
    Key key,
    @required this.toChatUser,
    @required this.userOnlineStatus,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(toChatUser.name),
          Text(
            _getStatusText(),
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  _getStatusText() {
    if (userOnlineStatus == UserOnlineStatus.online) {
      return 'Online';
    }
    if (userOnlineStatus == UserOnlineStatus.offline) {
      return 'Offline';
    }
    return 'Connecting';
  }
}
