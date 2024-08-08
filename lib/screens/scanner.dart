import 'package:flutter/material.dart';

class TicketScanner extends StatelessWidget {
  const TicketScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scanner"),
      ),
      body: const Center(child: Text("Hello  I am the scanner")),
    );
  }
}
