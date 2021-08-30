
import 'package:Bluestacks/model/auth_params.dart';
import 'package:Bluestacks/service/login_service.dart';

class LoginController {

  Future<bool> login(AuthParams params){
    return LoginService.login(params);
  }
}