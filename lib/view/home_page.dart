
import 'package:Bluestacks/constants/constants.dart';

import '../controller/home_controller.dart';
import '../model/tournaments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  HomeController _controller = HomeController();

  @override
  void initState() {
    super.initState();

    callAPIs();
  }

  void callAPIs() async {

    await _controller.getUserDetails();
    await _controller.getRecommendedTournaments();

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Flyingwolf", style: TextStyle(color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
          // reverse: true,
          itemCount: _controller.tournaments.length,
          itemBuilder: (context, index) {
            return _TournamentWidget(_controller.tournaments[index]);
          }
      ),
    );
  }

}

class _TournamentWidget extends StatelessWidget {

  final Tournament tournament;

  _TournamentWidget(this.tournament);

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: Dimensions.card_elevation,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.card_round_radius)
      ),
      margin: EdgeInsets.fromLTRB(Dimensions.card_margin, Dimensions.card_margin, Dimensions.card_margin, 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black54, Colors.transparent,],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              )
            ),
            child: Image.network(tournament.coverUrl ?? "", fit: BoxFit.cover, height: 90,),
          ),
          Padding(
            padding: EdgeInsets.all(Dimensions.card_padding * 2),
            child: Container(
                color: Colors.white,
                height: 50,
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
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8,),
                          Text(tournament.gameName ?? "")
                        ],
                      ),
                    ),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.keyboard_arrow_right, color: Colors.black87,))
                  ],
                )
            )
          )
        ],
      )
    );
  }

}