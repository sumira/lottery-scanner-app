import 'package:flutter/material.dart';

class LotteryNotifications extends StatefulWidget {
  const LotteryNotifications({super.key});

  @override
  State<LotteryNotifications> createState() => _LotteryNotificationsState();
}

class _LotteryNotificationsState extends State<LotteryNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Text("Hello I am the notifications page"),
      ),
    );
  }
}
