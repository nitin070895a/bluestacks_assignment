import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

import '../constants/constants.dart';
import '../model/tournaments.dart';
import '../model/user_details.dart';

class APIService {

  static Future<TournamentsResponse?> getRecommendedTournaments({String? cursor}) async {
    if (await _isConnected() == false) return null;

    String endPoint = ApiEndpoints.recommendedTournaments;
    if (cursor != null) endPoint += "&cursor=$cursor";
    Uri uri = Uri.parse(endPoint);

    final response = await http.get(uri);

    if(response.statusCode == 200)
      return TournamentsResponse.fromJson(jsonDecode(response.body));
  }

  static Future <UserDetails?> getUserDetails() async {
    if (await _isConnected() == false) return null;
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

  static Future<bool> _isConnected() async {
    var connectivityResult = await new Connectivity().checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi;
  }
}