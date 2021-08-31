import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'constants/constants.dart';
import 'constants/strings.dart';
import 'screens/home/home_page.dart';
import 'screens/login/login_page.dart';
import 'utils/preferences.dart';

void main() {
  runApp(GameTV());
}

class GameTV extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Bluestacks Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: AppColors.background
      ),
      supportedLocales: [
        Locale('en', ''),
        Locale('ja', ''),
      ],
      localizationsDelegates: [
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      localeResolutionCallback: (locale, supportedLocales) {

        for (var supportedLocale in supportedLocales)
          if (supportedLocale.languageCode == locale?.languageCode)
            return supportedLocale;

        return supportedLocales.first;
      },
      locale: ui.window.locale,
      home: FutureBuilder(
        future: Preferences.isLoggedIn(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data ?? false ? HomePage() : LoginPage();
          }
          return Container();
        },
      ),
      routes: {
        Routes.login : (context) => LoginPage(),
        Routes.home: (context) => HomePage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

