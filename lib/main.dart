import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottery_app/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _getPageRoute(RouteManager.homePage);
          } else {
            return _getPageRoute(RouteManager.login);
          }
        },
      ),
      onGenerateRoute: RouteManager.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }

  Widget _getPageRoute(String routeName) {
    return Navigator(
      onGenerateRoute: (settings) =>
          RouteManager.generateRoute(RouteSettings(name: routeName)),
    );
  }
}
