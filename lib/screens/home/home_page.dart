
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_controller.dart';
import '../../utils/enum.dart';
import '../../constants/strings.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/error_page.dart';
import '../../widgets/tournament.dart';
import '../../widgets/user_widget.dart';

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
  late Languages strings;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    _callAPIs();
  }

  /// Calls the initial set of APIs necessary for loading the page
  void _callAPIs() async {

    // Show Progress bar
    setState(() {
      _state = UIState.LOADING;
    });

    // Call the APIs
    await _callTournamentsAPI();
    await _controller.getUserDetails();

    // Hide progress bar and show UI
    setState(() {
      _state = _controller.userDetails != null ? UIState.LOADED : UIState.ERROR;
    });
  }

  /// Calls the API to fetch list of recommended tournaments
  Future<void> _callTournamentsAPI() async {
    await _controller.getRecommendedTournaments();
    _isFetchingMore = false;
  }

  /// Callback received from list view on scrolling
  void _scrollListener() {

    // Check if reached end of list
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent
        && !_scrollController.position.outOfRange && !_isFetchingMore) {

      // Call api again to fetch next page
      _isFetchingMore = true;
      _callTournamentsAPI().then((value) =>
          setState(() {
            // Update UI on result
          })
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    strings = Languages.of(context);

    return Scaffold(
      appBar: CustomAppBar("Flyingwolf",
        leadingIcon: Icon(Icons.drag_handle),
      ),
      body: _getRoot()
    );
  }

  /// Returns the root of the Home Page
  Widget _getRoot() {

    switch(_state) {

      case UIState.IDLE:
      case UIState.LOADING: return Center(child: CircularProgressIndicator());
      case UIState.LOADED: return _getListView();
      case UIState.ERROR: return ErrorPage(
        strings.errorLoadingPage, retry: _callAPIs,
      );
    }
  }

  /// Returns the widget with list of tournaments
  Widget _getListView() {

    return ListView.builder(
      controller: _scrollController,
      physics: BouncingScrollPhysics(),
      itemCount: _controller.tournaments.length + 3, // 1 for header, title and progress each
      itemBuilder: (context, index) {

        if (index == 0) return UserWidget(_controller.userDetails); // Profile
        if (index == 1) return CustomHeader(strings.recommendedForYou); // Title
        if (index == _controller.tournaments.length + 2) {
          if (_controller.deadEnd) return Container();
          else return Align(child: CircularProgressIndicator()); // Progress
        }

        // Return Tournament Widget
        return TournamentWidget(_controller.tournaments[index - 2]);
      }
    );
  }
}