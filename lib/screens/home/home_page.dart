import 'package:flutter/material.dart';
import 'package:lottery_app/data_models/ticket.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        const Row(
          children: [
            Padding(padding: EdgeInsets.fromLTRB(10, 24, 0, 0)),
            Text("Most Popular", style: TextStyle(fontWeight: FontWeight.bold)),
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
            Padding(padding: EdgeInsets.fromLTRB(10, 24, 0, 0)),
            Text("Find Latest Results Here",
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
          child: ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: null,
                  ),
                  title: Text(tickets[index].name),
                );
              }),
        )
      ],
    );
  }
}


// CustomButton(
//             onTab: 
//             text: "Logout"),