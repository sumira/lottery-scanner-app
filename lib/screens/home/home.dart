import 'package:flutter/material.dart';
import 'package:lottery_app/routes/routes.dart';
import 'package:lottery_app/screens/home/home_page.dart';
import 'package:lottery_app/pages/lottery_history.dart';
import 'package:lottery_app/pages/notifications.dart';
import 'package:lottery_app/pages/settings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    HomeScreen(),
    LotteryNotifications(),
    HomeScreen(), // Placeholder for scanner
    LotteryHistory(),
    Settings(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      // Open scanner
      Navigator.of(context).pushNamed(RouteManager.scanner);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 160,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {},
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        backgroundColor: Colors.blue[300],
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Colors.white,
                )),
          )
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavItem(Icons.home, 'Home', 0),
            _buildNavItem(Icons.notifications, 'Notifications', 1),
            _buildNavItem(Icons.camera, 'Scanner', 2, isScanner: true),
            _buildNavItem(Icons.access_time, 'History', 3),
            _buildNavItem(Icons.settings, 'Settings', 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index,
      {bool isScanner = false}) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isScanner
                ? Colors.blue[300]
                : (_selectedIndex == index ? Colors.blue[800] : Colors.grey),
            size: isScanner ? 30 : 24,
          ),
          Text(
            label,
            style: TextStyle(
              color: isScanner
                  ? Colors.blue[300]
                  : (_selectedIndex == index ? Colors.blue[800] : Colors.grey),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
