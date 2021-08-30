
import 'package:Bluestacks/model/tournaments.dart';
import 'package:Bluestacks/model/user_details.dart';
import 'package:Bluestacks/service/api_service.dart';

class HomeController {

  String? _cursor;
  bool _deadEnd = false;

  Future<UserDetails?> getUserDetails() async {
    return await APIService.getUserDetails();
  }

  Future<List<Tournament>?> getRecommendedTournaments() async {
    if (_deadEnd) return null;
    var response = await APIService.getRecommendedTournaments(cursor: _cursor);

    if (response?.success ?? false) {
      if (response!.data != null) {
        _cursor = response.data!.cursor;
        _deadEnd = response.data!.isLastBatch ?? false;
        return response.data!.tournaments;
      }
    }
  }
}