import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/view_model/page_model.dart';
import 'locator.dart';
import 'ui/widgets/bottom_navigation.dart';

void main() {
  setupLocator();
  runApp(Wassistant());
}

/// Main class
class Wassistant extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Wassistant',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _HomePage(),
      );
}

/// Home page
class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Instance of PageController
    final _pageController = PageController(initialPage: 0);

    // Returns scaffold widget with provider
    return ChangeNotifierProvider<PageModel>(
      builder: (_) => locator<PageModel>(),
      child: Consumer<PageModel>(
        builder: (_, pageModel, __) => Scaffold(
          appBar: AppBar(
            title: Text(pageModel.title),
          ),
          body: PageView(
            controller: _pageController,
            children: pageModel.pages,
            onPageChanged: pageModel.change,
          ),
          bottomNavigationBar: BottomNavigation(key, _pageController),
        ),
      ),
    );
  }
}
