import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/view_models/page_model.dart';
import '../../../core/view_models/search_model.dart';
import '../../../locator.dart';
import '../../widgets/bottom_navigation.dart';
import '../../widgets/search_floating_button.dart';
import 'pages/encyclopedia.dart';
import 'pages/player.dart';
import 'pages/settings.dart';

/// Home view
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Instance of PageController
    final _pageController = PageController(initialPage: 0);

    // Returns scaffold widget with providers
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: locator<PageModel>()),
        ChangeNotifierProvider.value(value: locator<SearchModel>()),
      ],
      child: Consumer<PageModel>(
        builder: (_, pageModel, __) => Scaffold(
          appBar: AppBar(title: Text(pageModel.title)),
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
          floatingActionButton: SearchFloatingButton(),
        ),
      ),
    );
  }
}
