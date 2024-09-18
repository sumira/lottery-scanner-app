import "package:flutter/material.dart";
import "package:lottery_app/screens/home/home.dart";
import "package:lottery_app/screens/scanner.dart";
import "package:lottery_app/screens/splash/splash.dart";

class RouteManager {
  static const String homePage = '/';
  static const String scanner = '/scanner';
  static const String splash = '/splash';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(builder: (context) => Home());
      case scanner:
        return MaterialPageRoute(builder: (context) => TicketScanner());
      case splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      default:
        throw const FormatException("Route not found, check the routes");
    }
  }
}
