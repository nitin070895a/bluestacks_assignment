import 'package:flutter/cupertino.dart';

abstract class Languages {

  static Languages of (BuildContext context) {
    return Localizations.of<Languages>(context, Languages)!;
  }

  String get appName;
  String get username;
  String get usernameHint;
  String get invalidUsername;
  String get password;
  String get passwordHint;
  String get invalidPassword;
  String get login;
  String get loginErrorUser;
  String get eloRating;
  String get tournamentsPlayed;
  String get tournamentsWon;
  String get winningPercentage;
  String get recommendedForYou;
  String get errorLoadingPage;
}

class LanguageEn extends Languages {

  @override String get appName => 'Bluestacks Assignment';
  @override String get username => 'Username';
  @override String get usernameHint => 'Enter your username';
  @override String get invalidUsername => 'Username must be between 3 to 11 characters.';
  @override String get password => 'Password';
  @override String get passwordHint => 'Enter your password';
  @override String get invalidPassword => 'Password must be between 3 to 11 characters.';
  @override String get login => "Login";
  @override String get loginErrorUser => "Authentication failed! Username or password is wrong";
  @override String get eloRating => "Elo Rating";
  @override String get tournamentsPlayed => "Tournaments played";
  @override String get tournamentsWon => "Tournaments won";
  @override String get winningPercentage => "Winning percentage";
  @override String get recommendedForYou => "Recommended for you";
  @override String get errorLoadingPage => "Error loading page";
}

class LanguageJa extends Languages {

  @override String get appName => 'Bluestacks Assignment';
  @override String get username => 'Username';
  @override String get usernameHint => 'Enter your username';
  @override String get invalidUsername => 'Username must be between 3 to 11 characters.';
  @override String get password => 'Password';
  @override String get passwordHint => 'Enter your password';
  @override String get invalidPassword => 'Password must be between 3 to 11 characters.';
  @override String get login => "Login";
  @override String get loginErrorUser => "Authentication failed! Username or password is wrong";
  @override String get eloRating => "Elo Rating";
  @override String get tournamentsPlayed => "Tournaments played";
  @override String get tournamentsWon => "Tournaments won";
  @override String get winningPercentage => "Winning percentage";
  @override String get recommendedForYou => "Recommended for you";
  @override String get errorLoadingPage => "Error loading page";
}

class AppLocalizationDelegate extends LocalizationsDelegate<Languages> {

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ja'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en': return LanguageEn();
      case 'ja': return LanguageJa();
      default: return LanguageEn();
    }
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<Languages> old) => false;

}