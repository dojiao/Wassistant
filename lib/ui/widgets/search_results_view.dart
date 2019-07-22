import 'package:flutter/material.dart';

import '../../core/view_models/search_model.dart';

/// Search results view
class SearchResultsView extends StatelessWidget {
  final SearchModel _search;

  /// Returns a widget to display the search results
  SearchResultsView(this._search);

  @override
  Widget build(BuildContext context) {
    final indicatorWeight = 2.0;
    final tabHeight = 44.0;
    final tabBarHeight = tabHeight + indicatorWeight;
    final textStyle = Theme.of(context).textTheme.subhead.copyWith(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(tabBarHeight),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.grey[50],
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: indicatorWeight,
              tabs: <Widget>[
                Container(
                  height: tabHeight,
                  child: Center(
                    child: Text('Players', style: textStyle),
                  ),
                ),
                Container(
                  height: tabHeight,
                  child: Center(
                    child: Text('Clans', style: textStyle),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(children: _buildTabs(context)),
      ),
    );
  }

  /// Returns a list of tabs
  List<Widget> _buildTabs(BuildContext context) => [
        ListView.builder(
          itemCount: _search.players.length,
          itemBuilder: (context, index) => Container(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text(_search.players[index].nickname),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: Theme.of(context).textTheme.subtitle.fontSize,
              ),
              onTap: () => Navigator.pushNamed(context, 'profile'),
            ),
          ),
        ),
        // TODO: display clans
        ListView.builder(
          itemCount: _search.players.length,
          itemBuilder: (context, index) => Container(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text(_search.players[index].nickname),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: Theme.of(context).textTheme.subtitle.fontSize,
              ),
              onTap: () => Navigator.pushNamed(context, 'profile'),
            ),
          ),
        ),
      ];
}
