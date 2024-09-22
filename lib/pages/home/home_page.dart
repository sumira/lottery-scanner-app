import 'package:flutter/material.dart';
import 'package:lottery_app/data_models/ticket.dart';
import 'package:lottery_app/pages/results_viewer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Ticket> allTickets = [];
  List<Ticket> filteredTickets = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTickets();
  }

  Future<void> _loadTickets() async {
    setState(() {
      isLoading = true;
    });

    final String baseUrl = 'http://10.0.2.2:5000';

    try {
      print('Fetching tickets from $baseUrl...');

      await TicketManager.fetchTicketsFromEndpoint(
          baseUrl: baseUrl, timeout: 15, maxRetries: 3);

      print('Tickets fetched successfully');

      setState(() {
        allTickets = TicketManager.tickets;
        filteredTickets = allTickets;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching tickets: $e');
      setState(() {
        isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Unable to load tickets. Please check your connection and try again.',
            ),
            duration: Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: _loadTickets,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _buildMostPopular()),
        SliverToBoxAdapter(child: _buildLatestResultsSearch(context)),
        SliverList(delegate: _buildTicketsList()),
      ],
    );
  }

  Widget _buildMostPopular() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            "Most Popular",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 80,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: allTickets.length > 6 ? 6 : allTickets.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _navigateToLotteryResults(allTickets[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        width: 100,
                        color: Colors.white,
                        child: Image.asset(allTickets[index].imagePath,
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLatestResultsSearch(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Text(
            "Find Latest Results Here",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search Lotteries Here",
                prefixIcon: Icon(Icons.search, color: Colors.blue[300]),
                suffixIcon: Icon(Icons.mic, color: Colors.blue[300]),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onChanged: (value) {
                setState(() {
                  filteredTickets = allTickets
                      .where((ticket) => ticket.name
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  SliverChildBuilderDelegate _buildTicketsList() {
    return SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(
              filteredTickets[index].imagePath,
            ),
            backgroundColor: Colors.blue[300],
          ),
          title: Text(filteredTickets[index].name),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            _navigateToLotteryResults(filteredTickets[index]);
          },
        );
      },
      childCount: filteredTickets.length,
    );
  }

  void _navigateToLotteryResults(Ticket ticket) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LotteryResultsScreen(
          lotteryName: ticket.name,
          drawNumber: ticket.drawNumber,
          drawDate: ticket.date,
          winningNumbers: ticket.winningNumbers,
          specialCharacter: ticket.specialCharacter,
          lotteryImageUrl: ticket.imagePath,
        ),
      ),
    );
  }
}
