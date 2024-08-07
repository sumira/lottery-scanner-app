import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, color: Colors.white),
                    onPressed: () {},
                  ),
                  Spacer(),
                  CircleAvatar(
                    radius: 24.0,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 36.0),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.blue,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hi Saman!',
                  style: TextStyle(color: Colors.white, fontSize: 24.0),
                ),
              ),
            ),
            Container(
              color: Colors.blue,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Most Popular',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.network('https://via.placeholder.com/100x60', height: 60.0),
                      Image.network('https://via.placeholder.com/100x60', height: 60.0),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find Latest Results Here',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ResultCard(name: 'Lagna Wasana', date: '2024-May-31(Friday)', code: 'F', numbers: '8 7 6 9 1'),
                  ResultCard(name: 'Jayoda', date: '2024-May-31(Friday)', code: 'H', numbers: '4 4 4 5 6 7 5'),
                  ResultCard(name: 'Ada Kotipathi', date: '2024-May-31(Friday)', code: 'H', numbers: '5 4 2'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        shape: CircularNotchedRectangle(),
        notchMargin: 16.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(icon: Icon(Icons.notifications, color: Colors.white), onPressed: () {}),
              IconButton(icon: Icon(Icons.star, color: Colors.white), onPressed: () {}),
              SizedBox(width: 48), 
              IconButton(icon: Icon(Icons.timer, color: Colors.white), onPressed: () {}),
              IconButton(icon: Icon(Icons.settings, color: Colors.white), onPressed: () {}),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_a_photo),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class ResultCard extends StatelessWidget {
  final String name;
  final String date;
  final String code;
  final String numbers;

  ResultCard({required this.name, required this.date, required this.code, required this.numbers});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(name),
        subtitle: Text(date),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(code, style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
            Text(numbers),
          ],
        ),
      ),
    );
  }
}
