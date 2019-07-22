import 'package:flutter/material.dart';

/// Bottom navigation bar
class NotchedBottomNavigationBar extends StatelessWidget {
  /// Constructor
  NotchedBottomNavigationBar(this._pageController);

  // Instance of PageController
  final PageController _pageController;

  @override
  Widget build(BuildContext context) => BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                color: Theme.of(context).primaryColor,
                icon: Icon(Icons.home),
                onPressed: () {
                  _pageController.jumpToPage(0);
                },
              ),
              IconButton(
                color: Theme.of(context).primaryColor,
                icon: Icon(Icons.settings),
                onPressed: () {
                  _pageController.jumpToPage(1);
                },
              ),
            ],
          ),
        ),
      );
}
