import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'constants/constants.dart';
import 'constants/strings.dart';
import 'screens/home/home_page.dart';
import 'screens/login/login_page.dart';
import 'utils/preferences.dart';

void main() {
  runApp(_GameTV());
}

/// The Main App Widget
class _GameTV extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Bluestacks Assignment',
      theme: _getTheme(),
      debugShowCheckedModeBanner: false,
      supportedLocales: [Locale('en', ''), Locale('ja', ''),],
      localizationsDelegates: [
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      localeResolutionCallback: _localeResolutionCallback,
      locale: ui.window.locale,
      home: _HomeWidget(),
      routes: {
        Routes.login : (context) => LoginPage(),
        Routes.home: (context) => HomePage()
      },
    );
  }

  /// Callback to handle locale resolution
  Locale _localeResolutionCallback(
      Locale? locale, Iterable<Locale> supportedLocales) {

    for (var supportedLocale in supportedLocales)
      if (supportedLocale.languageCode == locale?.languageCode)
        return supportedLocale;

    return supportedLocales.first;
  }

  /// Returns customised app theme data
  ThemeData _getTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: AppColors.background,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.text_field_round_radius)
        )
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: Dimensions.font_xxlarge,
          color: Colors.black87
        ),
        headline2: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: Dimensions.font_xlarge,
        ),
        headline6: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: Dimensions.font_large,
        ),
        bodyText2: TextStyle(
          fontSize: Dimensions.font_normal
        ),
      ),
      cardTheme: CardTheme(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: Dimensions.card_elevation,
        shadowColor: Colors.black38,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.card_round_radius)
        ),
        margin: EdgeInsets.fromLTRB(Dimensions.card_margin,
            Dimensions.card_margin, Dimensions.card_margin, 2
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.black87
      ),
    );
  }
}

/// Calculates and builds the initial page to be loaded into the app
///
/// If user is logged in builds [HomePage] otherwise builds [LoginPage].
class _HomeWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   return FutureBuilder(
     future: Preferences.isLoggedIn(),
     builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
       if (snapshot.hasData) {
         return snapshot.data ?? false ? HomePage() : LoginPage();
       }
       return Container();
     },
   );
  }
}