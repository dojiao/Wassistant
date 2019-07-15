import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/view_models/widgets/search_model.dart';
import '../../locator.dart';

/// AppBar with a search button
class SearchAppBar extends StatelessWidget with PreferredSizeWidget {
  /// Constructor
  SearchAppBar(Key key, this.title) : super(key: key);

  /// Title text
  final String title;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<SearchModel>(
        builder: (_) => locator<SearchModel>(),
        child: Consumer<SearchModel>(
          builder: (_, search, ___) => AppBar(
            title: Text(title),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: _PlayerSearchDelegate(search),
                  );
                },
              ),
            ],
          ),
        ),
      );
}

/// SearchDelegate for searching player data
class _PlayerSearchDelegate extends SearchDelegate {
  final SearchModel _search;

  /// Constructor
  _PlayerSearchDelegate(this._search);

  @override
  Widget buildSuggestions(BuildContext context) {
    // if query is empty
    if (query.isEmpty) {
      // returns a empty widget
      return ListView.builder(
        itemCount: _search.histories.length,
        itemBuilder: (_, index) => ListTile(
          leading: Icon(Icons.history),
          title: Text(_search.histories[index]),
          onTap: () => print('Search history'),
        ),
      );
    }

    // otherwise returns a ListView contains two item
    return ListView(
      padding: EdgeInsets.all(8.0),
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),
          child: ListTile(
            leading: Icon(Icons.person_outline),
            title: Text(query),
            trailing: Text('Players'),
            onTap: () => showResults(context),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),
          child: ListTile(
            leading: Icon(Icons.outlined_flag),
            title: Text(query),
            trailing: Text('Clans'),
            onTap: () {
              print('Search clans');
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => close(context, null), // close search page
      );

  @override
  List<Widget> buildActions(BuildContext context) => <Widget>[
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => (query = ''), // clear the typed search query string
        ),
      ];
}
