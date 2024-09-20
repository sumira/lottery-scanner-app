import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottery_app/pages/login/signUp/login.dart';
import 'package:lottery_app/routes/routes.dart';
import 'package:lottery_app/screens/home/home_page.dart';
import 'package:lottery_app/pages/lottery_history.dart';
import 'package:lottery_app/pages/notifications.dart';
import 'package:lottery_app/pages/settings.dart';
import 'package:lottery_app/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  String? userName;

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      try {
        QuerySnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: user.email)
            .limit(1)
            .get();

        if (userSnapshot.docs.isNotEmpty) {
          setState(() {
            userName = userSnapshot.docs.first['name'];
          });
        } else {
          setState(() {
            userName = 'User';
          });
        }
      } catch (e) {
        print('Error fetching user name: $e');
        setState(() {
          userName = 'User';
        });
      }
    }
  }

  static final List<Widget> _pages = <Widget>[
    HomeScreen(),
    LotteryNotifications(),
    HomeScreen(),
    LotteryHistory(),
    SettingsPage(),
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
            Icons.logout,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () async {
            await AuthServices().signOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        backgroundColor: Colors.blue[300],
        flexibleSpace: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome,',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                userName ?? 'User',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
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
