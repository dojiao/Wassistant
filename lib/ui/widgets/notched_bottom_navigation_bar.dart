import 'package:flutter/material.dart';

/// Bottom navigation bar
class NotchedBottomNavigationBar extends StatelessWidget {
  /// Instance of PageController
  final PageController _pageController;

  /// Constructor
  NotchedBottomNavigationBar(this._pageController);

  @override
  Widget build(BuildContext context) {
    final spacing = 6.0;
    final iconColor = Theme.of(context).primaryColor;
    final iconSize = 28.0;

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: spacing,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: spacing),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              color: iconColor,
              iconSize: iconSize,
              icon: Icon(Icons.home),
              onPressed: () => _pageController.jumpToPage(0),
            ),
            IconButton(
              color: iconColor,
              iconSize: iconSize,
              icon: Icon(Icons.settings),
              onPressed: () => _pageController.jumpToPage(1),
            ),
          ],
        ),
      ),
    );
  }
}
