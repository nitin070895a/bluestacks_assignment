import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

import '../constants/constants.dart';
import '../model/tournaments.dart';
import '../model/user_details.dart';

/// Central service providing all APIs to be used in the app
class APIService {

  /// Fetches recommended tournaments from the server and returns the response
  ///
  /// The API supports pagination, provide an optional [cursor] to be passed to
  /// the server as a starting point in the data
  static Future<TournamentsResponse?> getRecommendedTournaments(
      {String? cursor}) async {

    if (await _isConnected() == false) return null;

    // Prepare URI
    String endPoint = ApiEndpoints.recommendedTournaments;
    if (cursor != null) endPoint += "&cursor=$cursor";
    Uri uri = Uri.parse(endPoint);

    // Call the API
    final response = await http.get(uri);

    // Parse the data
    if(response.statusCode == 200)
      return TournamentsResponse.fromJson(jsonDecode(response.body));
  }

  /// Fetches users profile from the server and returns it
  ///
  /// Note: Mock-up, Waits for 1 second and returns hardcoded response
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

  /// Checks for internet connectivity, returns true if network is connected
  static Future<bool> _isConnected() async {
    var connectivityResult = await new Connectivity().checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
}