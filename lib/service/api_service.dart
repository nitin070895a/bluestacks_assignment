
import 'dart:convert';

import 'package:Bluestacks/constants/constants.dart';
import 'package:Bluestacks/model/tournaments.dart';
import 'package:Bluestacks/model/user_details.dart';
import 'package:http/http.dart' as http;

class APIService {

  static Future<TournamentsResponse?> getRecommendedTournaments({String? cursor}) async {

    String endPoint = ApiEndpoints.recommendedTournaments;
    if (cursor != null) endPoint += "&cursor=$cursor";
    Uri uri = Uri.parse(endPoint);

    final response = await http.get(uri);

    if(response.statusCode == 200)
      return TournamentsResponse.fromJson(jsonDecode(response.body));
  }

  static Future <UserDetails?> getUserDetails() {
    return Future.delayed(Duration(milliseconds: 1000), () {
      return UserDetails(jsonDecode("""
      {
        "name": "Simon Baker",
        "ratings": 2250,
        "tournaments_played": 34,
        "tournaments_won": 9
      }
      """));
    });
  }
}