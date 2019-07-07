import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wassistant/pages/encyclopedia.dart';
import 'package:wassistant/pages/player.dart';
import 'package:wassistant/pages/settings.dart';
import 'package:wassistant/store/page.dart';
import 'package:wassistant/widgets/bottom_navigation.dart';

void main() => runApp(MyApp());

/// Main class
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<Page>(builder: (_) => Page()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      );
}

/// Home page design declaration
class MyHomePage extends StatelessWidget {
  /// Constructor
  MyHomePage({Key key, this.title}) : super(key: key);

  /// Title text
  final String title;

  @override
  Widget build(BuildContext context) {
    // Get page index from provider
    final _page = Provider.of<Page>(context);

    // Instance of PageController
    final _pageController = PageController(initialPage: 0);

    // Returns scaffold widget
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
