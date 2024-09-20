import 'package:flutter/material.dart';

class LotteryHistory extends StatefulWidget {
  const LotteryHistory({super.key});

  @override
  State<LotteryHistory> createState() => _LotteryHistoryState();
}

class _LotteryHistoryState extends State<LotteryHistory> {
  final List<Map<String, String>> scannedTickets = [
    {
      "ticketNumber": "123456",
      "scanDate": "2024-09-15",
      "result": "Winner: \$100"
    },
    {
      "ticketNumber": "654321",
      "scanDate": "2024-09-10",
      "result": "Not a Winner"
    },
    {
      "ticketNumber": "789012",
      "scanDate": "2024-09-08",
      "result": "Winner: \$500"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scanned Ticket History"),
        centerTitle: true,
      ),
      body: scannedTickets.isEmpty ? _buildEmptyState() : _buildHistoryList(),
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

  Widget _buildHistoryList() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: scannedTickets.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          child: ListTile(
            leading: Icon(
              Icons.confirmation_number,
              color: Colors.green,
            ),
            title: Text("Ticket #${scannedTickets[index]["ticketNumber"]}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Scan Date: ${scannedTickets[index]["scanDate"]}"),
                Text("Result: ${scannedTickets[index]["result"]}"),
              ],
            ),
          ),
        );
      },
    );
  }
}
