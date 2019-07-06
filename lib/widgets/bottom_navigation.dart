import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wassistant/store/page.dart';

/// Bottom navigation bar
class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<Page>(
        builder: (_, page, ___) => BottomNavigationBar(
              currentIndex: page.index,
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
              onTap: page.change,
            ),
      );
}
