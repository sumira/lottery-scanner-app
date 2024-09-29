import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Ticket {
  final String name;
  final String drawNumber;
  final String winningNumbers;
  final String imagePath;
  final String date;
  final String specialCharacter;

  Ticket(
    this.name,
    this.drawNumber,
    this.date,
    this.winningNumbers,
    this.specialCharacter,
    this.imagePath,
  );

  factory Ticket.fromJson(Map<String, dynamic> json) {
    String formatDate(String inputDate) {
      if (inputDate.contains('-')) {
        final inputFormat = DateFormat("yyyy-MMM-dd EEEE");
        final outputFormat = DateFormat("dd/MM/yyyy");
        try {
          final date = inputFormat.parse(inputDate);
          return outputFormat.format(date);
        } catch (e) {
          print('Date format error: $e');
          return inputDate; // Fallback to input date if parsing fails
        }
      } else {
        return inputDate;
      }
    }

    return Ticket(
      json['name'],
      json['draw'],
      formatDate(json['date']),
      json['results']
          .where((item) => item is String && int.tryParse(item) != null)
          .join(' '),
      json['results'].firstWhere(
          (item) =>
              item is String && item.length == 1 && int.tryParse(item) == null,
          orElse: () => ''),
      "assets/${json['name'].toLowerCase().replaceAll(' ', '_')}.png",
    );
  }
}

class TicketManager {
  static List<Ticket> _tickets = [];

  static List<Ticket> get tickets => _tickets;

  // Flexible fetchTicketsFromEndpoint with dynamic baseUrl
  static Future<void> fetchTicketsFromEndpoint({
    required String baseUrl,
    int timeout = 10,
    int maxRetries = 3,
  }) async {
    final url = Uri.parse('$baseUrl/latest-results');
    int retries = 0;

    while (retries < maxRetries) {
      try {
        print('Fetching from $url, attempt ${retries + 1}');
        final response =
            await http.get(url).timeout(Duration(seconds: timeout));

        if (response.statusCode == 200) {
          print('Tickets fetched successfully');
          final List<dynamic> jsonData = json.decode(response.body);
          _tickets = jsonData.map((json) => Ticket.fromJson(json)).toList();
          return; // Success, exit the function
        } else {
          throw HttpException(
              'Failed to load tickets, status code: ${response.statusCode}');
        }
      } on SocketException catch (e) {
        print('SocketException: Unable to reach the server. Error: $e');
        if (retries == maxRetries - 1) rethrow;
      } on TimeoutException catch (e) {
        print('TimeoutException: Server took too long to respond. Error: $e');
        if (retries == maxRetries - 1) rethrow;
      } on HttpException catch (e) {
        print('HttpException: ${e.message}');
        if (retries == maxRetries - 1) rethrow;
      } catch (e) {
        print('Unknown error occurred: $e');
        if (retries == maxRetries - 1) rethrow;
      }

      retries++;
      await Future.delayed(
          Duration(seconds: 2 * retries)); // Exponential backoff
    }
  }

  static Ticket? getTicketByName(String name) {
    try {
      return _tickets.firstWhere(
          (ticket) => ticket.name.toLowerCase() == name.toLowerCase());
    } catch (e) {
      print('Ticket not found: $name');
      return null;
    }
  }
}
