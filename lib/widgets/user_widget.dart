
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'score_card.dart';
import '../constants/constants.dart';
import '../constants/strings.dart';
import '../model/user_details.dart';

/// UI Widget to represent [UserDetails]
class UserWidget extends StatelessWidget {

  final UserDetails? userDetails;

  UserWidget(this.userDetails);

  @override
  Widget build(BuildContext context) {
    Languages strings = Languages.of(context);
    ThemeData theme = Theme.of(context);
    Radius r = Radius.circular(25);

    return Container(
      margin: EdgeInsets.all(Dimensions.card_margin),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(radius: 50, backgroundImage: AssetImage(Images.logo)),
              SizedBox(width: 20,),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userDetails?.name ?? "",
                    style: Theme.of(context).textTheme.headline1
                  ),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.primaryColor, width: 2),
                      borderRadius: BorderRadius.all(r),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Text(
                              userDetails?.ratings.toString() ?? "",
                              style: theme.textTheme.headline2?.apply(
                                color: theme.primaryColor
                              )
                            )
                          ),
                          TextSpan(text: "  "),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Text(strings.eloRating)
                          )
                        ]
                      ),
                    )
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _wrap(ScoreCard(
                  userDetails?.tournamentsPlayed.toString() ?? "",
                  strings.tournamentsPlayed,
                  BorderRadius.only(topLeft: r, bottomLeft: r),
                  Colors.orange)
              ),
              _wrap(ScoreCard(
                  userDetails?.tournamentsWon.toString() ?? "",
                  strings.tournamentsWon,
                  BorderRadius.zero,
                  Colors.purple)
              ),
              _wrap(ScoreCard(
                  "${userDetails?.winPercentage.toInt() ?? 0}%",
                  strings.winningPercentage,
                  BorderRadius.only(topRight: r, bottomRight: r),
                  Colors.red)
              ),
            ],
          )
        ],
      )
    );
  }

  Widget _wrap(ScoreCard scoreCard) {
    return Expanded(flex: 1, child: scoreCard);
  }
}