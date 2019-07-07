import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wassistant/pages/index/encyclopedia.dart';
import 'package:wassistant/pages/index/player.dart';
import 'package:wassistant/pages/index/settings.dart';
import 'package:wassistant/store/page.dart';
import 'package:wassistant/widgets/bottom_navigation.dart';

void main() => runApp(Wassistant());

/// Main class
class Wassistant extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<Page>(builder: (_) => Page()),
        ],
        child: MaterialApp(
          title: 'Wassistant',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: _HomePage(),
        ),
      );
}

/// Home page design declaration
class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get page index from provider
    final _page = Provider.of<Page>(context);

    // Instance of PageController
    final _pageController = PageController(initialPage: 0);

    // Returns scaffold widget
    return Scaffold(
      appBar: AppBar(
        title: Text('Player'),
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          PlayerPage(),
          EncyclopediaPage(),
          SettingsPage(),
        ],
        onPageChanged: _page.change,
      ),
      bottomNavigationBar: BottomNavigation(key, _pageController),
    );
  }
}
