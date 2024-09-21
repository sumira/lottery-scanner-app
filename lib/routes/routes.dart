import "package:flutter/material.dart";
import "package:lottery_app/pages/login/signUp/login.dart";
import "package:lottery_app/pages/home/home.dart";
import "package:lottery_app/pages/scanner.dart";
import "package:lottery_app/pages/splash/splash.dart";

class RouteManager {
  static const String homePage = '/';
  static const String scanner = '/scanner';
  static const String splash = '/splash';
  static const String login = '/login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(builder: (context) => Home());
      case scanner:
        return MaterialPageRoute(builder: (context) => TicketScanner());
      case splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case login:
        return MaterialPageRoute(builder: (context) => LoginScreen());

      default:
        throw const FormatException("Route not found, check the routes");
    }
  }
}
