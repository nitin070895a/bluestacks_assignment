
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Generates a bottom to top gradient of [color] mixed with transparency
getGradientBoxDecoration(Color color) => BoxDecoration(
    gradient: LinearGradient(
      colors: [color, Colors.transparent,],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    )
);