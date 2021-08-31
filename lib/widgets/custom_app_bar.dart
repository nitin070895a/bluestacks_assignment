
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Custom App bar widget for all scaffolds in the app
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {

  final String title;
  final Icon? leadingIcon;

  /// Creates the app bar with [title] and optional [leadingIcon]
  CustomAppBar(this.title, {this.leadingIcon}): preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  State<StatefulWidget> createState() => _CustomAppBarState(title, leadingIcon: leadingIcon);

}

/// Custom App bar state
class _CustomAppBarState extends State<CustomAppBar> {

  final String title;
  final Icon? leadingIcon;

  _CustomAppBarState(this.title, {this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(title, style: TextStyle(color: Colors.black)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      leading: leadingIcon != null ? IconButton(
        icon: leadingIcon!,
        onPressed: () {},
      ) : null,
    );
  }

}
