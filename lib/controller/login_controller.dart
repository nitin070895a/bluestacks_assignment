
import '../model/auth_params.dart';
import '../service/login_service.dart';

class LoginController {

  Future<bool> login(AuthParams params){
    return LoginService.login(params);
  }
}