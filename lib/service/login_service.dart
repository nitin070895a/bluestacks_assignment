
import '../model/auth_params.dart';

class LoginService {

  static Map<String, String>? _validLoginCredentials;

  static void _initialise() {
    _validLoginCredentials = Map();
    _validLoginCredentials!["9898989898"] = "password123";
    _validLoginCredentials!["9876543210"] = "password123";
    // _validLoginCredentials!["test"] = "test";
  }

  static Future<bool> login(AuthParams params) {
    if (_validLoginCredentials == null) _initialise();

    return Future.delayed(const Duration(milliseconds: 1000),() {
      return _validLoginCredentials?[params.userName] == params.password;
    });
  }
}