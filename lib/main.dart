import 'package:flutter/material.dart';
import 'package:lottery_app/routes/routes.dart';

void main() {
  runApp(const MaterialApp(
    initialRoute: RouteManager.homePage,
    onGenerateRoute: RouteManager.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}
