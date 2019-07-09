import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'store/page.dart';
import 'widgets/bottom_navigation.dart';

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
        title: Text(_page.title),
      ),
      body: PageView(
        controller: _pageController,
        children: _page.pages,
        onPageChanged: _page.change,
      ),
      bottomNavigationBar: BottomNavigation(key, _pageController),
    );
  }
}
