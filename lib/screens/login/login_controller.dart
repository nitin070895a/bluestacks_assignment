
import 'login_page.dart';
import '../../model/auth_params.dart';
import '../../service/login_service.dart';
import '../../utils/preferences.dart';

/// Controller for [LoginPage]
class LoginController {

  /// Authenticates a user with [params], returns true if authenticated
  Future<bool> login(AuthParams params) async{
    print('Sending Login Request...');

    var success = await LoginService.login(params);
    if (success) Preferences.setLoggedIn(true);

    print('Login ${success ? "Success" : "Failed"}!');

    return success;
  }
}