
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

/// Builds a custom bold header wit [title]
class CustomHeader extends StatelessWidget {

  final String title;

  CustomHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Dimensions.card_margin, right: Dimensions.card_margin
      ),
      child: Text(title,
        style: Theme.of(context).textTheme.headline1
      ),
    );
  }

}