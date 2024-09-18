import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottery_app/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    initialRoute: RouteManager.homePage,
    onGenerateRoute: RouteManager.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}
