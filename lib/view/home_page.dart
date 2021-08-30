
import 'package:Bluestacks/controller/home_controller.dart';
import 'package:Bluestacks/model/tournaments.dart';
import 'package:Bluestacks/model/user_details.dart';
import 'package:Bluestacks/persistent/preferences.dart';
import 'package:Bluestacks/service/api_service.dart';
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

    callAPIs();
  }

  void callAPIs() async {

    UserDetails? details = await _controller.getUserDetails();
    List<Tournament>? tournaments = await _controller.getRecommendedTournaments();

    if (details != null)
      print(details);
    if (tournaments != null)
      print(tournaments);
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
    );
  }

}