import 'package:flutter/material.dart';

import '../../core/mixins/date_helper.dart';
import '../../core/view_models/search_model.dart';
import '../router.dart';

/// Search results view
class SearchResultsView extends StatelessWidget with DateHelper {
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

  /// Returns a list of widget that inside the tabs
  List<ListView> _buildTabs(BuildContext context) => [
        ListView.builder(
          shrinkWrap: true,
          itemCount: _search.players.length,
          itemBuilder: (context, index) => Container(
            child: _buildPlayerCard(context, index),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _search.clans.length,
          itemBuilder: (context, index) => Container(
            child: _buildClanCard(context, index),
          ),
        ),
      ];

  /// returns card widget to display the player info
  Card _buildPlayerCard(BuildContext context, int index) {
    final _textTheme = Theme.of(context).textTheme;
    final _player = _search.players[index];

    return Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black26),
              ),
            ),
            child: Icon(Icons.person),
          ),
          title: Text(
            _player.nickname,
            style: _textTheme.subhead.copyWith(fontWeight: FontWeight.w600),
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: _textTheme.headline.fontSize,
          ),
          onTap: () => Navigator.pushNamed(context, '/playerData'),
        ),
      ),
    );
  }

  /// returns a card widget to display the clan info
  Card _buildClanCard(BuildContext context, int index) {
    final _textTheme = Theme.of(context).textTheme;
    final _clan = _search.clans[index];

    return Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          leading: Container(
            margin: EdgeInsets.symmetric(vertical: 12.0),
            padding: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black26),
              ),
            ),
            child: Icon(Icons.flag),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 4,
                child: Container(
                  child: Text(
                    _clan.tag,
                    style: _textTheme.subhead.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Text(
                  formatDateTime(_clan.createdAt),
                  textAlign: TextAlign.end,
                  style: _textTheme.caption.copyWith(
                    color: Colors.black38,
                  ),
                ),
              )
            ],
          ),
          subtitle: Container(
            child: Text(_clan.name),
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: _textTheme.headline.fontSize,
          ),
          onTap: () => Navigator.pushNamed(
            context,
            '/clanDetail',
            arguments: ViewArguments(clanId: _clan.clanId),
          ),
        ),
      ),
    );
  }
}
