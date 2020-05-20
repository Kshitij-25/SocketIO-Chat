import 'package:chat_socket/SocketIOChat/chat_user_screen.dart';
import 'package:chat_socket/SocketIOChat/login_screen.dart';

class Routes {
  static routes() {
    return {
      LoginScreen.Route_ID: (ctx) => LoginScreen(),
      ChatUserScreen.Route_ID: (ctx)=> ChatUserScreen(),
      
    };
  }

  static initScreen() {
    return LoginScreen.Route_ID;
  }
}
