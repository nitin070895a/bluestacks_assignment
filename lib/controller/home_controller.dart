
import '../model/user_details.dart';
import '../model/tournaments.dart';
import '../service/api_service.dart';

class HomeController {

  String? _cursor;
  bool _deadEnd = false;
  List<Tournament> _tournaments = [];
  UserDetails? _userDetails;

  List<Tournament> get tournaments => _tournaments;
  UserDetails? get userDetails => _userDetails;
  bool get deadEnd => _deadEnd;

  Future<UserDetails?> getUserDetails() async {
    _userDetails = await APIService.getUserDetails();
    return _userDetails;
  }

  Future<List<Tournament>> getRecommendedTournaments() async {
    if (!_deadEnd) {
      var response = await APIService.getRecommendedTournaments(cursor: _cursor);

      if (response?.success ?? false) {
        if (response!.data != null) {
          _cursor = response.data!.cursor;
          _deadEnd = response.data!.isLastBatch ?? false;
          var iTournament = response.data!.tournaments;
          if (iTournament != null) _tournaments.addAll(iTournament);
        }
      }
    }
    return _tournaments;
  }
}