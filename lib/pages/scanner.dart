import 'package:flutter/material.dart';

class TicketScanner extends StatelessWidget {
  const TicketScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Scanner'),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue[300],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[100]!, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildScanOption(
                context: context,
                title: 'Open Camera',
                icon: Icons.camera_alt,
                onPressed: () {
                  // TODO: Implement camera functionality
                  print('Camera button pressed');
                },
              ),
              const SizedBox(height: 40),
              _buildScanOption(
                context: context,
                title: 'Open Gallery',
                icon: Icons.photo_library,
                onPressed: () {
                  // TODO: Implement gallery functionality
                  print('Gallery button pressed');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScanOption({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.blue[800],
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(24),
              backgroundColor: Colors.blue[300],
              elevation: 5,
            ),
            child: Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
