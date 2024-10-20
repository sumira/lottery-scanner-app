import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LotteryHistory extends StatefulWidget {
  const LotteryHistory({super.key});

  @override
  State<LotteryHistory> createState() => _LotteryHistoryState();
}

class _LotteryHistoryState extends State<LotteryHistory> {
  static const String TICKETS_KEY = 'lottery_tickets';
  List<Map<String, dynamic>> tickets = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTickets();
  }

  Future<void> loadTickets() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> ticketStrings = prefs.getStringList(TICKETS_KEY) ?? [];

      setState(() {
        tickets = ticketStrings.map((ticketString) {
          try {
            return Map<String, dynamic>.from(jsonDecode(ticketString));
          } catch (e) {
            print('Error decoding ticket: $e');
            return <String, dynamic>{};
          }
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error loading tickets: $e');
      setState(() {
        tickets = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scanned Ticket History"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : tickets.isEmpty
              ? _buildEmptyState()
              : _buildHistoryList(),
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
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        final ticket = tickets[index];
        final doubleChance =
            (ticket['double_chance'] as List?)?.join(', ') ?? 'N/A';
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
                    leading: const Icon(
                      Icons.confirmation_number,
                      color: Colors.green,
                    ),
                    title: Text("Ticket - ${ticket['type'] ?? 'N/A'}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Date: ${ticket['date'] ?? 'N/A'}"),
                        Text(
                            "Numbers: ${(ticket['numbers'] as List?)?.join(', ') ?? 'N/A'}"),
                        if (doubleChance != 'N/A')
                          Text("Double Chance: $doubleChance"),
                        Text("Scanned by: ${ticket['username'] ?? 'Unknown'}"),
                        Text(
                            "Scanned on: ${_formatTimestamp(ticket['timestamp'])}"),
                      ],
                    ),
                  ),
                ),
                if (hasWinningChance)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
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

  String _formatTimestamp(String? timestamp) {
    if (timestamp == null) return 'Unknown';
    try {
      final DateTime date = DateTime.parse(timestamp);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
    } catch (e) {
      return 'Invalid Date';
    }
  }
}
