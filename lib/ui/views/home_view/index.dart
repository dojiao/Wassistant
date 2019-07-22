import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/view_models/search_model.dart';
import '../../../locator.dart';
import '../../widgets/notched_bottom_navigation_bar.dart';
import '../../widgets/search_floating_button.dart';
import 'pages/home_page.dart';
import 'pages/settings_page.dart';

/// Home view
class HomeView extends StatelessWidget {
  // Instance of PageController
  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: locator<SearchModel>()),
        ],
        child: Scaffold(
          body: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomePage(),
              SettingsPage(),
            ],
          ),
          bottomNavigationBar: NotchedBottomNavigationBar(_pageController),
          floatingActionButton: SearchFloatingButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      );
}
