import 'package:elomia_test/screens/auth/auth_screen.dart';
import 'package:elomia_test/screens/chat/chat_screen.dart';
import 'package:elomia_test/screens/concerns/conserns_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.auth:
      return MaterialPageRoute(
          builder: (context) => const AuthScreen(), settings: settings);
    case Routes.concernsScreen:
      return MaterialPageRoute(
          builder: (context) => const ConcernsScreen(), settings: settings);

    case Routes.chatScreen:
      return MaterialPageRoute(
          builder: (context) => const ChatScreen(), settings: settings);
  }
  return null;
}

class Routes {
  static const auth = '/auth_screen';
  static const chatScreen = '/chat_screen';
  static const concernsScreen = '/concerns_screen';
}
