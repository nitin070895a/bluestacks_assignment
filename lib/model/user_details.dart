class UserDetails {

  late String name;
  late int ratings;
  late int tournamentsPlayed;
  late int tournamentsWon;

  double get winPercentage =>
      tournamentsPlayed < 1 ? 0 : tournamentsWon / tournamentsPlayed * 100;

  UserDetails(Map<String, dynamic> json) {
    this.name = json["name"];
    this.ratings = json["ratings"];
    this.tournamentsPlayed = json["tournaments_played"];
    this.tournamentsWon = json["tournaments_won"];
  }
}