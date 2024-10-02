import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottery_app/services/notifications_service.dart';
import 'package:collection/collection.dart';

class LotteryNotifications extends StatefulWidget {
  const LotteryNotifications({Key? key}) : super(key: key);

  @override
  State<LotteryNotifications> createState() => _LotteryNotificationsState();
}

class _LotteryNotificationsState extends State<LotteryNotifications> {
  List<Map<String, dynamic>> notifications = [];
  bool isLoading = true;
  final LocalNotificationsService _notificationsService =
      LocalNotificationsService();

  @override
  void initState() {
    super.initState();
    _initializeFirebaseAndFetchData();
  }

  Future<void> _initializeFirebaseAndFetchData() async {
    await Firebase.initializeApp();
    await _fetchDataAndCompare();
  }

  Future<void> _fetchDataAndCompare() async {
    setState(() => isLoading = true);

    try {
      final lotteryResults =
          await FirebaseFirestore.instance.collection('lottery_results').get();
      final savedTickets =
          await FirebaseFirestore.instance.collection('saved_tickets').get();

      List<Map<String, dynamic>> newNotifications = [];
      int notificationId = 0;

      for (var ticket in savedTickets.docs) {
        final ticketData = ticket.data();

        final matchingResult = lotteryResults.docs.firstWhereOrNull(
          (result) =>
              result['date'].split(' ')[0] == ticketData['date'] &&
              result['draw'] == ticketData['draw_no'],
        );

        if (matchingResult != null) {
          final resultData = matchingResult.data();
          final ticketNumbers = List<String>.from(ticketData['numbers']);
          final resultNumbers = List<String>.from(resultData['results'].values);

          bool hasWon =
              ticketNumbers.any((number) => resultNumbers.contains(number));

          String message = hasWon
              ? "You won on your lottery ticket!"
              : "Your ticket did not win this time.";

          newNotifications.add({
            "title": ticketData['type'],
            "message": message,
            "time": _formatTime(ticketData['timestamp']),
          });

          // Show local notification
          await _notificationsService.showNotification(
            id: notificationId++,
            title: ticketData['type'],
            body: message,
          );
        } else {
          String message = "The draw is upcoming. Don't forget!";
          newNotifications.add({
            "title": ticketData['type'],
            "message": message,
            "time": _formatTime(ticketData['timestamp']),
          });

          // Show local notification for upcoming draw
          await _notificationsService.showNotification(
            id: notificationId++,
            title: ticketData['type'],
            body: message,
          );
        }
      }

      setState(() {
        notifications = newNotifications;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() => isLoading = false);
    }
  }

  String _formatTime(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate().toString();
    } else if (timestamp is String) {
      return timestamp;
    }
    return 'Unknown time';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lottery Notifications"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : notifications.isEmpty
              ? _buildEmptyState()
              : _buildNotificationList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          const Text(
            "No Notifications",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          const Text(
            "You don't have any notifications right now.",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          child: ListTile(
            leading: const Icon(
              Icons.notifications,
              color: Colors.blueAccent,
            ),
            title: Text(notifications[index]["title"]!),
            subtitle: Text(notifications[index]["message"]!),
            trailing: Text(
              notifications[index]["time"]!,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),
        );
      },
    );
  }
}
