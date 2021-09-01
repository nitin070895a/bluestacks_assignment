
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Creates a fancy UI widget to represent score
class ScoreCard extends StatelessWidget {

  final String value;
  final String title;
  final BorderRadius radius;
  final MaterialColor color;

  /// Constructor
  ///
  /// Builds a [color] scorecard with [title] and score [value], specify a
  /// [BorderRadius] to control round edges
  ScoreCard(this.value, this.title, this.radius, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: LinearGradient(
          colors: [color.shade800, color.shade400,],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        )
      ),
      child: Center(
        child: Column(
          children: [
            Text(value, style: Theme.of(context).textTheme.headline2?.apply(
              color: Colors.white
            ),),
            SizedBox(height: 5,),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2?.apply(
                color: Colors.white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
