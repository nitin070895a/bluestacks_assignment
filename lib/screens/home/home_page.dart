
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_controller.dart';
import '../../constants/constants.dart';
import '../../utils/enum.dart';
import '../../constants/strings.dart';
import '../../model/user_details.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/score_card.dart';
import '../../widgets/tournament.dart';

// Provides the UI for Home Page
class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _HomePageState();

}

// Home Page State
class _HomePageState extends State<HomePage> {

  HomeController _controller = HomeController(); // The Controller

  ScrollController _scrollController = ScrollController(); // List controller

  UIState _state = UIState.IDLE; // Current UI state
  bool _isFetchingMore = false;  // Flag to indicate pagination progress

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    _callAPIs();
  }

  void _callAPIs() async {

    setState(() {
      _state = UIState.LOADING;
    });

    await _callTournamentsAPI();
    await _controller.getUserDetails();

    setState(() {
      _state = _controller.userDetails != null ? UIState.LOADED : UIState.ERROR;
    });
  }

  Future<void> _callTournamentsAPI() async {
    await _controller.getRecommendedTournaments();
    _isFetchingMore = false;
  }

  void _scrollListener() {

    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange && !_isFetchingMore) {

      _isFetchingMore = true;
      _callTournamentsAPI().then((value) =>
          setState(() {

          })
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Flyingwolf", leadingIcon: Icon(Icons.drag_handle),),
      body: getRoot()
    );
  }

  Widget getRoot() {
    Languages strings = Languages.of(context);
    switch(_state) {

      case UIState.IDLE:
      case UIState.LOADING: return Center(child: CircularProgressIndicator());
      case UIState.ERROR: return Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(strings.errorLoadingPage, style: TextStyle(color: Colors.red),),
          SizedBox(height: Dimensions.card_margin,),
          OutlinedButton(onPressed: _callAPIs, child: Text(strings.retry),)
        ],
      ));
      case UIState.LOADED: return ListView.builder(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
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
            return TournamentWidget(_controller.tournaments[index-2]);
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
                  Text(userDetails?.name ?? "", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: Dimensions.font_xxlarge),),
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
                              WidgetSpan(alignment: PlaceholderAlignment.middle, child: Text(userDetails?.ratings.toString() ?? "", style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.font_xlarge, color: Colors.blue))),
                              TextSpan(text: "  "),
                              WidgetSpan(alignment: PlaceholderAlignment.middle, child: Text(strings.eloRating))
                            ]
                        ),
                      )
                    ),
                ],
              )
            ],
          ),
          SizedBox(height: Dimensions.card_margin,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(flex: 1, child: ScoreCard(userDetails?.tournamentsPlayed.toString() ?? "", strings.tournamentsPlayed, BorderRadius.only(topLeft: r, bottomLeft: r), Colors.orange)),
              Expanded(flex: 1, child: ScoreCard(userDetails?.tournamentsWon.toString() ?? "", strings.tournamentsWon, BorderRadius.zero, Colors.purple)),
              Expanded(flex: 1, child: ScoreCard("${userDetails?.winPercentage.toInt() ?? 0}%", strings.winningPercentage, BorderRadius.only(topRight: r, bottomRight: r), Colors.red)),
            ],
          )
        ],
      )
    );
  }

}