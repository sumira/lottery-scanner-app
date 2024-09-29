import 'package:flutter/material.dart';

class LotteryNotifications extends StatefulWidget {
  const LotteryNotifications({super.key});

  @override
  State<LotteryNotifications> createState() => _LotteryNotificationsState();
}

class _LotteryNotificationsState extends State<LotteryNotifications> {
  final List<Map<String, String>> notifications = [
    {
      "title": "Mahajana Sampatha",
      "message": "You won 100 on your lottery ticket!",
      "time": "2 hours ago"
    },
    {
      "title": "Shanida",
      "message": "Your ticket did not win this time.",
      "time": "1 day ago"
    },
    {
      "title": "Kotipathi Kapruka",
      "message": "The draw is in 3 hours. Don't forget!",
      "time": "2 days ago"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
      ),
      body:
          notifications.isEmpty ? _buildEmptyState() : _buildNotificationList(),
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
            leading: Icon(
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
