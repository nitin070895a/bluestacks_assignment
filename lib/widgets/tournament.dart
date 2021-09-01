
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/tournaments.dart';
import '../utils/widget_utils.dart';

/// UI Widget to represent a [Tournament]
class TournamentWidget extends StatelessWidget {

  final Tournament tournament;

  TournamentWidget(this.tournament);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              foregroundDecoration: getGradientBoxDecoration(Colors.black),
              child: Image.network(
                tournament.coverUrl ?? "",
                fit: BoxFit.cover,
                height: 90,
              ),
            ),
            Container(
              color: Colors.white, height: 60, padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tournament.name ?? "",
                          style: Theme.of(context).textTheme.headline6,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5,),
                        Text(tournament.gameName ?? "")
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_right),
                    onPressed: (){},
                  )
                ],
              )
            )
          ],
        )
    );
  }

}