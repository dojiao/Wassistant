import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/view_models/page_model.dart';
import '../../../locator.dart';
import '../../widgets/bottom_navigation.dart';
import '../../widgets/search_app_bar.dart';
import 'pages/encyclopedia.dart';
import 'pages/player.dart';
import 'pages/settings.dart';

/// Home view
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Instance of PageController
    final _pageController = PageController(initialPage: 0);

    // Returns scaffold widget with provider
    return ChangeNotifierProvider<PageModel>(
      builder: (_) => locator<PageModel>(),
      child: Consumer<PageModel>(
        builder: (_, pageModel, __) => Scaffold(
          appBar: SearchAppBar(key, pageModel.title),
          body: PageView(
            controller: _pageController,
            children: [
              PlayerPage(),
              EncyclopediaPage(),
              SettingsPage(),
            ],
            onPageChanged: pageModel.change,
          ),
          bottomNavigationBar: BottomNavigation(key, _pageController),
        ),
      ),
    );
  }
}
