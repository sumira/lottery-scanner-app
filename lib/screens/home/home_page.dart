import 'package:flutter/material.dart';
import 'package:lottery_app/screens/home/home.dart';
import 'package:lottery_app/screens/scanner.dart';
// Placeholder import for Settings page

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          Home(),
          TicketScanner(), // Placeholder widget for Scanner page
        ],
      ),
    );
  }
}
