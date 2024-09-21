import 'package:flutter/material.dart';

class LotteryResultsScreen extends StatelessWidget {
  final String lotteryName;
  final String drawNumber;
  final String drawDate;
  final String winningNumbers;
  final String specialCharacter;
  final String lotteryImageUrl;

  const LotteryResultsScreen({
    Key? key,
    required this.lotteryName,
    required this.drawNumber,
    required this.drawDate,
    required this.winningNumbers,
    required this.specialCharacter,
    required this.lotteryImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lottery Results'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.blue.shade50,
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset(
                    lotteryImageUrl,
                    height: 120,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error, size: 120, color: Colors.red);
                    },
                  ),
                  SizedBox(height: 16),
                  Text(
                    lotteryName,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Draw Number', drawNumber),
                  _buildInfoRow('Date', drawDate),
                  SizedBox(height: 24),
                  Text(
                    'Winning Numbers',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8),
                  Text(
                    winningNumbers,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                  ),
                  SizedBox(height: 16),
                  _buildInfoRow('Special Character', specialCharacter,
                      isHighlighted: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value,
      {bool isHighlighted = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
              color: isHighlighted ? Colors.blue : null,
            ),
          ),
        ],
      ),
    );
  }
}
