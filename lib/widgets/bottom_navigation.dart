import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wassistant/store/page.dart';

/// Bottom navigation bar
class BottomNavigation extends StatelessWidget {
  /// Constructor
  BottomNavigation(Key key, this._pageController) : super(key: key);

  // Instance of PageController
  final PageController _pageController;

  @override
  Widget build(BuildContext context) => Consumer<Page>(
        builder: (_, page, ___) => BottomNavigationBar(
          currentIndex: page.currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Player'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              title: Text('Encyclopedia'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
          onTap: (int index) {
            _pageController.jumpToPage(index);
            page.change(index);
          },
        ),
      );
}
