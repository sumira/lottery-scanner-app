import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/screens/home/home.dart';

void main() {
  runApp(const MaterialApp(
    home: Sandbox(),
  ));
}

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: <Widget>[
          // const SizedBox(
          //   height: 10,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Container(
                  alignment: Alignment.center,
                  constraints: BoxConstraints(
                    maxWidth: screenWidth - 10,
                    maxHeight: 200,
                  ),
                  color: Colors.cyan.shade400,
                  child: const Text('ClipRRect'),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(8),
              children: [
                Container(
                  height: 50,
                  width: 100,
                  color: Colors.red[600],
                ),
                Container(
                  height: 50,
                  width: 100,
                  color: Colors.red[500],
                ),
                Container(
                  height: 50,
                  width: 100,
                  color: Colors.red[400],
                ),
                Container(
                  height: 50,
                  width: 100,
                  color: Colors.red[300],
                ),
                Container(
                  height: 50,
                  width: 100,
                  color: Colors.red[200],
                ),
                Container(
                  height: 50,
                  width: 100,
                  color: Colors.red[100],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          Expanded(
              child: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              Container(
                height: 150,
                color: Colors.amber[600],
                child: const Center(child: Text('Entry A')),
              ),
              Container(
                height: 150,
                color: Colors.amber[500],
                child: const Center(child: Text('Entry B')),
              ),
              Container(
                height: 150,
                color: Colors.amber[400],
                child: const Center(child: Text('Entry C')),
              ),
              Container(
                height: 150,
                color: Colors.amber[300],
                child: const Center(child: Text('Entry D')),
              ),
              Container(
                height: 150,
                color: Colors.amber[200],
                child: const Center(child: Text('Entry E')),
              ),
            ],
          ))
        ],
      ),
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan.shade400,
        tooltip: 'Increment',
        onPressed: () {},
        shape: CircleBorder(),
        child: const Icon(Icons.camera, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        color: Colors.cyan.shade400,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.notification_important,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.star,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.lock_clock,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
