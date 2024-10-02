import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LotteryHistory extends StatefulWidget {
  const LotteryHistory({super.key});

  @override
  State<LotteryHistory> createState() => _LotteryHistoryState();
}

class _LotteryHistoryState extends State<LotteryHistory> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scanned Ticket History"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('saved_tickets').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return _buildEmptyState();
          }

          return _buildHistoryList(snapshot.data!.docs);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          const Text(
            "No Ticket History",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          const Text(
            "You haven't scanned any tickets yet.",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(List<QueryDocumentSnapshot> tickets) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        final ticket = tickets[index].data() as Map<String, dynamic>;
        final doubleChance = ticket['double_chance']?.join(', ') ?? 'N/A';
        final hasWinningChance = ticket['winning_chance'] == true;

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: Icon(
                      Icons.confirmation_number,
                      color: Colors.green,
                    ),
                    title: Text("Ticket - ${ticket['type'] ?? 'N/A'}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Date: ${ticket['date'] ?? 'N/A'}"),
                        Text(
                            "Numbers: ${ticket['numbers']?.join(', ') ?? 'N/A'}"),
                        if (doubleChance != 'N/A')
                          Text("Double Chance: $doubleChance"),
                      ],
                    ),
                  ),
                ),
                if (hasWinningChance)
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Winning Chance!',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
