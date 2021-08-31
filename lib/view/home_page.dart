
import 'package:Bluestacks/constants/constants.dart';
import 'package:Bluestacks/constants/enum.dart';
import 'package:Bluestacks/constants/strings.dart';
import 'package:Bluestacks/model/user_details.dart';

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
  UIState _state = UIState.IDLE;
  ScrollController _scrollController = ScrollController();
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    callAPIs();
  }

  void callAPIs() async {

    _state = UIState.LOADING;

    await callTournamentsAPI();
    await _controller.getUserDetails();

    setState(() {
      _state = _controller.userDetails != null ? UIState.LOADED : UIState.ERROR;
    });
  }

  Future<void> callTournamentsAPI() async {
    await _controller.getRecommendedTournaments();
    _isFetchingMore = false;
  }

  void _scrollListener() {

    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange && !_isFetchingMore) {

      _isFetchingMore = true;
      callTournamentsAPI().then((value) =>
          setState(() {

          })
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Flyingwolf", style: TextStyle(color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: Icon(Icons.drag_handle),
          onPressed: (){},
        ),
      ),
      body: getRoot()
    );
  }

  Widget getRoot() {
    Languages strings = Languages.of(context);
    switch(_state) {

      case UIState.IDLE:
      case UIState.LOADING: return Center(child: CircularProgressIndicator());
      case UIState.ERROR: return Center(child: Text(strings.errorLoadingPage));
      case UIState.LOADED: return ListView.builder(
          controller: _scrollController,
          itemCount: _controller.tournaments.length + 3,
          itemBuilder: (context, index) {
            if (index == 0) return _UserDetails(_controller.userDetails);
            if (index == 1) return Container(
              margin: EdgeInsets.only(left: Dimensions.card_margin, right: Dimensions.card_margin),
              child: Text(
                strings.recommendedForYou,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.font_xxlarge,
                ),
              ),
            );
            if (index == _controller.tournaments.length + 2) {
              if (_controller.deadEnd) return Container();
              else return Align(child: CircularProgressIndicator());
            }
            return _TournamentWidget(_controller.tournaments[index-2]);
          }
      );

      default: return Center(child: Text(strings.errorLoadingPage));
    }
  }

}

class _UserDetails extends StatelessWidget {

  final UserDetails? userDetails;

  _UserDetails(this.userDetails);

  @override
  Widget build(BuildContext context) {
    Languages strings = Languages.of(context);
    Radius r = Radius.circular(25);
    return Container(
      margin: EdgeInsets.all(Dimensions.card_margin),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(Images.logo),
              ),
              SizedBox(width: Dimensions.card_margin,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userDetails?.name ?? "", style: Theme.of(context).textTheme.headline4,),
                  SizedBox(height: 10,),
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      padding: EdgeInsets.all(Dimensions.card_padding * 2),
                      child: Text.rich(
                        TextSpan(
                            children: [
                              TextSpan(text: userDetails?.ratings.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.font_xlarge, color: Colors.blue)),
                              TextSpan(text: "  "),
                              TextSpan(text: strings.eloRating)
                            ]
                        ),
                        textAlign: TextAlign.center,
                      )
                  )
                ],
              )
            ],
          ),
          SizedBox(height: Dimensions.card_margin,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(flex: 1, child: _ScoreCard(userDetails?.tournamentsPlayed.toString() ?? "", strings.tournamentsPlayed, BorderRadius.only(topLeft: r, bottomLeft: r), Colors.orange)),
              Expanded(flex: 1, child: _ScoreCard(userDetails?.tournamentsWon.toString() ?? "", strings.tournamentsPlayed, BorderRadius.zero, Colors.purple)),
              Expanded(flex: 1, child: _ScoreCard("${userDetails?.winPercentage.toInt() ?? 0}%", strings.tournamentsPlayed, BorderRadius.only(topRight: r, bottomRight: r), Colors.red)),
            ],
          )
        ],
      )
    );
  }

}

class _ScoreCard extends StatelessWidget {

  final String value;
  final String title;
  final BorderRadius radius;
  final MaterialColor color;

  _ScoreCard(this.value, this.title, this.radius, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
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
            Text(value, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: Dimensions.font_xlarge),),
            SizedBox(height: 5,),
            Text(title, style: TextStyle(color: Colors.white,), textAlign: TextAlign.center, ),
          ],
        ),
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
                            style: TextStyle(fontSize: Dimensions.font_large, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5,),
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