import 'package:chat_socket/SocketIOChat/chat_screen.dart';
import 'package:chat_socket/SocketIOChat/chat_user_screen.dart';
import 'package:chat_socket/SocketIOChat/login_screen.dart';

class Routes {
  static routes() {
    return {
      LoginScreen.Route_ID: (ctx) => LoginScreen(),
      ChatUserScreen.Route_ID: (ctx) => ChatUserScreen(),
      ChatScreen.Route_ID: (ctx) => ChatScreen(),
      
    };
  }

  static initScreen() {
    return LoginScreen.Route_ID;
  }
}
