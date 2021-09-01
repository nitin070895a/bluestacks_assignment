
/// Data representation of user's profile
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['ratings'] = this.ratings;
    data['tournaments_played'] = this.tournamentsPlayed;
    data['tournaments_won'] = this.tournamentsWon;
    return data;
  }
}