
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_controller.dart';
import '../../constants/constants.dart';
import '../../utils/enum.dart';
import '../../constants/strings.dart';
import '../../utils/extension.dart';
import '../../model/auth_params.dart';
import '../../widgets/custom_app_bar.dart';

// Provides the UI for Login Page
class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

// Login Page State
class _LoginPageState extends State<LoginPage> {

  final _controller = LoginController(); // The Controller

  final _formKey = GlobalKey<FormState>();
  final _userName = TextEditingController();  // Controller for user name
  final _password = TextEditingController();  // Controller for password

  UIState _loginState = UIState.IDLE; // Current UI state of the page
  var _isFormValid = false;
  late Languages strings;

  @override
  Widget build(BuildContext context) {
    strings = Languages.of(context);

    return Scaffold(
        appBar: CustomAppBar(strings.login),
        resizeToAvoidBottomInset: true,
        body: Form(
            key: _formKey,
            onChanged: _onFormEdit,
            child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(Dimensions.login_form_margin),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage(Images.logo), width: 100, height: 100,
                      ),
                      SizedBox(height: Dimensions.login_form_spacing,),
                      TextFormField(
                        controller: _userName,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: _usernameValidation,
                        decoration: InputDecoration(
                          hintText: strings.usernameHint,
                          labelText: strings.username,
                        ),
                      ),
                      SizedBox(height: Dimensions.login_form_spacing,),
                      TextFormField(
                        controller: _password,
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: _passwordValidation,
                        decoration: InputDecoration(
                          hintText: strings.passwordHint,
                          labelText: strings.password,
                        ),
                      ),
                      SizedBox(height: Dimensions.login_form_spacing,),
                      _getLoginButton(),
                      _getErrorText()
                    ],
                  ),
                )
            )
        )
    );
  }

  // Returns UI widget for login button
  Widget _getLoginButton() =>
    OutlinedButton(
      child: Text(strings.login),
      onPressed: (_isFormValid && _loginState != UIState.LOADING)?
        _onLoginPressed : null,
    );

  /// Returns UI widget for error text
  Widget _getErrorText() => Text(
    _loginState == UIState.ERROR ? strings.loginErrorUser : "",
    style: TextStyle(color: Colors.red),
    textAlign: TextAlign.center,
  );

  /// Validates user name and returns a corresponding error string
  String? _usernameValidation(String? text) => (text?.isEmpty ?? true) ? ""
      : text?.isValidUsername() ?? true ? null : strings.invalidUsername;

  /// Validates password and returns a corresponding error string
  String? _passwordValidation(String? text) => (text?.isEmpty ?? true) ? ""
      : text?.isValidPassword() ?? true ? null : strings.invalidPassword;

  /// Form edit callback
  void _onFormEdit() {

    setState(() {
      _isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  /// Callback from Login button click, Calls the controller for login event
  void _onLoginPressed() async {

    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _loginState = UIState.LOADING;
    });

    AuthParams params = AuthParams(_userName.text, _password.text);
    bool success = await _controller.login(params);

    setState(() {
      _loginState = success ? UIState.LOADED : UIState.ERROR;
    });

    if (success)
      Navigator.pushReplacementNamed(context, Routes.home);
  }
}