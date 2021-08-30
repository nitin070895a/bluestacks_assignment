import 'package:Bluestacks/constants/enum.dart';
import 'package:Bluestacks/controller/login_controller.dart';
import 'package:Bluestacks/model/auth_params.dart';
import 'package:Bluestacks/persistent/preferences.dart';
import 'package:Bluestacks/view/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../extension.dart';
import '../constants/constants.dart';
import '../constants/strings.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  final _userName = TextEditingController();
  final _password = TextEditingController();

  final _controller = LoginController();
  UIState _loginState = UIState.IDLE;
  var _isValid = false;

  @override
  Widget build(BuildContext context) {
    Languages strings = Languages.of(context);
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(strings.login, style: TextStyle(color: Colors.black)),
            elevation: 0,
            backgroundColor: Colors.transparent,
        ),
        resizeToAvoidBottomInset: true,
        body: Form(
            key: _formKey,
            onChanged: (){
              setState(() {
                _isValid = _formKey.currentState?.validate() ?? false;
              });
            },
            child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(Dimensions.login_form_margin),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(image: AssetImage(Images.logo), width: 100, height: 100,),
                      SizedBox(height: Dimensions.login_form_spacing,),
                      TextFormField(
                        controller: _userName,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            hintText: strings.usernameHint,
                            labelText: strings.username,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(Dimensions.text_field_round_radius)
                            )
                        ),
                        validator: (text) => (text?.isEmpty ?? true) ? "" : text?.isValidUsername() ?? true ? null : strings.invalidUsername,
                      ),
                      SizedBox(height: Dimensions.login_form_spacing,),
                      TextFormField(
                        controller: _password,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: strings.passwordHint,
                          labelText: strings.password,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimensions.text_field_round_radius)
                          ),
                        ),
                        validator: (text) => (text?.isEmpty ?? true) ? "" : text?.isValidPassword() ?? true ? null : strings.invalidPassword,
                        obscureText: true,
                      ),
                      SizedBox(height: Dimensions.login_form_spacing,),
                      OutlineButton(
                        child: Text(strings.login),
                        onPressed: (_isValid && _loginState != UIState.LOADING)? onLoginPressed : null,
                      ),
                      Text(_loginState == UIState.ERROR ? strings.loginErrorUser : "", style: TextStyle(color: Colors.red),textAlign: TextAlign.center,),
                    ],
                  ),
                )
            )
        )
    );
  }

  void onLoginPressed() async {

    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _loginState = UIState.LOADING;
    });

    AuthParams params = AuthParams(_userName.text, _password.text);
    bool success = await _controller.login(params);

    setState(() {
      _loginState = success ? UIState.LOADED : UIState.ERROR;
    });

    print('Login ${success ? "Success" : "Failed"}!');

    if (success) {
      Preferences.setLoggedIn(true);
      Navigator.pushReplacementNamed(context, Routes.home);
    }
  }
}