class Ticket {
  final String name;
  final String drawNumber;
  final String winningNumbers;
  final String imagePath;
  final String date;
  final String specialCharacter;
  final bool isWinner;

  Ticket(
    this.name,
    this.drawNumber,
    this.date,
    this.winningNumbers,
    this.specialCharacter,
    this.isWinner,
    this.imagePath,
    
  );
}

List tickets = [
  Ticket('Mahajana Sampatha','5200','24/09/2024', '12 14 15 25','E',false, "assets/mahajana_sampatha.jpeg"),
  Ticket('Lagna Wasanawa','','', '','',false, "assets/lagna_wasanawa.png"),
  Ticket('Neeroga','','', '','',false, "assets/neeroga.png"),
  Ticket('Dana Nidanaya','','', '','',false, "assets/dana_nidanaya.png"),
  Ticket('Govisetha','','', '','',false, "assets/govisetha.png"),
  Ticket('Super Ball','','', '','',false, "assets/super_ball.jpg"),
  Ticket('Shanida Wasanawa','','', '','',false, "assets/shanida_wasanawa.jpeg"),
  Ticket('Jayoda','','', '','',false,"assets/jayoda.jpg"),
];
