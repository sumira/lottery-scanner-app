import 'package:flutter/material.dart';
import 'package:lottery_app/screens/home/home.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
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
      appBar: AppBar(
        toolbarHeight: 120,
      ),
      body: Column(
        children: <Widget>[
          // const SizedBox(
          //   height: 10,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     ClipRRect(
          //       borderRadius: BorderRadius.circular(30.0),
          //       child: Container(
          //         alignment: Alignment.center,
          //         constraints: BoxConstraints(
          //           maxWidth: screenWidth - 10,
          //           maxHeight: 200,
          //         ),
          //         color: Colors.cyan.shade400,
          //         child: const Text('ClipRRect'),
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(
            height: 5,
          ),

          SizedBox(
            height: 100,
            child: ListView(
              padding: const EdgeInsets.all(4.0),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: 100,
                      color: Colors.red[600],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: 100,
                      color: Colors.red[500],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: 100,
                      color: Colors.red[400],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: 100,
                      color: Colors.red[300],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: 100,
                      color: Colors.red[200],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: 100,
                      color: Colors.red[100],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),

          Expanded(
              child: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Container(
                  height: 150,
                  color: Colors.amber[600],
                  child: const Center(child: Text('Entry A')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Container(
                  height: 150,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Entry B')),
                ),
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
