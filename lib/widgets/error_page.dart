
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../constants/strings.dart';

/// UI Widget for loading error page with a retry button
class ErrorPage extends StatelessWidget {

  final String errorMessage;
  final VoidCallback? retry;

  ErrorPage(this.errorMessage, {this.retry});

  @override
  Widget build(BuildContext context) {
    Languages strings = Languages.of(context);

    return Center(
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Text(errorMessage, style: TextStyle(color: Colors.red),),
         SizedBox(height: Dimensions.card_margin,),
         if (retry != null)
           OutlinedButton(onPressed: retry, child: Text(strings.retry),)
       ],
     ));
  }

}