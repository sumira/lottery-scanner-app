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
}

List tickets = [
  Ticket('Mahajana Sampatha', '5200', '24/09/2024', '12 14 15 25', 'E',
      "assets/mahajana_sampatha.jpeg"),
  Ticket('Lagna Wasanawa', '', '', '', '', "assets/lagna_wasanawa.png"),
  Ticket('Neeroga', '', '', '', '', "assets/neeroga.png"),
  Ticket('Dana Nidanaya', '', '', '', '', "assets/dana_nidanaya.png"),
  Ticket('Govisetha', '', '', '', '', "assets/govisetha.png"),
  Ticket('Super Ball', '', '', '', '', "assets/super_ball.jpg"),
  Ticket('Shanida Wasanawa', '', '', '', '', "assets/shanida_wasanawa.jpeg"),
  Ticket('Jayoda', '', '', '', '', "assets/jayoda.jpg"),
];
