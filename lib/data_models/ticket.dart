class Ticket {
  final String name;
  final String drawNumber;
  final String winningNumbers;
  final String imagePath;

  Ticket(
    this.name,
    this.drawNumber,
    this.winningNumbers,
    this.imagePath,
  );
}

List tickets = [
  Ticket('Mahajana Sampatha', '', '', "assets/mahajana_sampatha.jpeg"),
  Ticket('Lagna Wasanawa', '', '', "assets/lagna_wasanawa.png"),
  Ticket('Neeroga', '', '', "assets/neeroga.png"),
  Ticket('Dana Nidanaya', '', '', "assets/dana_nidanaya.png"),
  Ticket('Govisetha', '', '', "assets/govisetha.png"),
  Ticket('Super Ball', '', '', "assets/super_ball.jpg"),
  Ticket('Shanida Wasanawa', '', '', "assets/shanida_wasanawa.jpeg"),
  Ticket('Jayoda', '', '', "assets/jayoda.jpg"),
];
