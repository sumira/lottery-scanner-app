import 'package:flutter/material.dart';

class LotteryHistory extends StatefulWidget {
  const LotteryHistory({super.key});

  @override
  State<LotteryHistory> createState() => _LotteryHistoryState();
}

class _LotteryHistoryState extends State<LotteryHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Text("Hello I am the lottery history"),
      ),
    );
  }
}
