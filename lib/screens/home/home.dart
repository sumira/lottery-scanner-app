import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
      body: Column(
        children: <Widget>[
          // const SizedBox(
          //   height: 10,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     ClipRRect(
          //       borderRadius: const BorderRadius.only(
          //           bottomLeft: Radius.circular(30),
          //           bottomRight: Radius.circular(30)),
          //       child: Container(
          //         alignment: Alignment.center,
          //         constraints: BoxConstraints(
          //           maxWidth: screenWidth,
          //           maxHeight: 200,
          //         ),
          //         color: Colors.blue[300],
          //         child: const Text('ClipRRect'),
          //       ),
          //     ),
          //   ],
          // ),

          const Row(
            children: [
              const Padding(padding: EdgeInsets.fromLTRB(10, 24, 0, 0)),
              const Text("Most Popular",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
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

          const Row(
            children: [
              const Padding(padding: EdgeInsets.fromLTRB(10, 24, 0, 0)),
              const Text("Find Latest Results Here",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),

          const Padding(
            padding: EdgeInsets.only(top: 8, left: 6, right: 6),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search Lotteries Here",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green))),
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
              Container(
                height: 150,
                color: Colors.amber[200],
                child: const Center(child: Text('Entry E')),
              ),
            ],
          ))
        ],
      ),
      //extendBody: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[300],
        tooltip: 'Increment',
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(Icons.camera, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        color: Colors.blue[300],
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.notifications,
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
                Icons.access_time,
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
