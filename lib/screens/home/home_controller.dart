
import 'home_page.dart';
import '../../model/user_details.dart';
import '../../model/tournaments.dart';
import '../../service/api_service.dart';

/// Controller for [HomePage]
class HomeController {

  String? _cursor;
  bool _deadEnd = false;
  List<Tournament> _tournaments = [];
  UserDetails? _userDetails;

  List<Tournament> get tournaments => _tournaments;
  UserDetails? get userDetails => _userDetails;
  bool get deadEnd => _deadEnd;

  /// Fetches and returns the user details, returns null in case of error
  Future<UserDetails?> getUserDetails() async {
    print('Fetching user details...');

    _userDetails = await APIService.getUserDetails();

    print('User Details ${_userDetails?.toJson().toString()}');

    return _userDetails;
  }

  /// Fetches the list of recommended tournaments, returns null in case of error
  Future<List<Tournament>> getRecommendedTournaments() async {

    if (!_deadEnd) {
      print('Fetching recommended tournaments');
      var response = await APIService.getRecommendedTournaments(cursor: _cursor);

      if (response?.success ?? false) {

        if (response!.data != null) {

          // Update cursor and last page flag
          _cursor = response.data!.cursor;
          _deadEnd = response.data!.isLastBatch ?? false;

          // Update tournaments list
          var iTournaments = response.data!.tournaments;
          if (iTournaments != null) _tournaments.addAll(iTournaments);

        } else print('No data found');

      } else print('Responded in failure');

    } else print('Tournaments list reached the last page');

    print('Total Tournaments: ${_tournaments.length}');

    return _tournaments;
  }
}