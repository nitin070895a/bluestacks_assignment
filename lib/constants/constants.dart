
import 'dart:ui';

import 'package:flutter/material.dart';

/// All the images used in the app
class Images {

  static const _root = "assets/images";

  static const logo = "$_root/logo.png";
}

/// All the custom colors user in the app
class AppColors {

  static const white = const Color(0xffffffff);
  static const background = const Color(0xfff9f9f9);
}

/// All Dimensions like margin, padding, radius, font sizes etc
class Dimensions {

  static const login_form_margin = 50.0;
  static const login_form_spacing = 20.0;
  static const text_field_round_radius = 10.0;
  static const card_round_radius = 20.0;
  static const card_elevation = 2.0;
  static const card_margin = 18.0;
  static const card_padding = 5.0;

  static const font_small = 12.0;
  static const font_normal = 14.0;
  static const font_large = 16.0;
  static const font_xlarge = 20.0;
  static const font_xxlarge = 26.0;
}

/// All named routes
class Routes {

  static const login = "/login";
  static const home = "/home";
}

// All API endpoints used in the app
class ApiEndpoints {

  static const recommendedTournaments = "http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all";
}