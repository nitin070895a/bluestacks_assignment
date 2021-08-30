
import 'package:Bluestacks/persistent/preferences.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    Preferences.setLoggedIn(false);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("This is Home Page"),
    );
  }

}