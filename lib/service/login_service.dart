
import '../model/auth_params.dart';

/// API calling service providing APIs for Login Page
class LoginService {

  static Map<String, String>? _validLoginCredentials;

  /// Hardcoded valid login credentials
  static void _initialise() {
    _validLoginCredentials = Map();
    _validLoginCredentials!["9898989898"] = "password123";
    _validLoginCredentials!["9876543210"] = "password123";
  }

  /// Sends an authentication request for provided [params]
  ///
  /// Note: Mockup, Waits for 1 second and returns result based on validation
  static Future<bool> login(AuthParams params) {
    if (_validLoginCredentials == null) _initialise();

    return Future.delayed(const Duration(milliseconds: 1000),() {
      return _validLoginCredentials?[params.userName] == params.password;
    });
  }
}