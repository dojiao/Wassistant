import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/view_models/widgets/search_histories_model.dart';
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
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<SearchHistoriesModel>(
        builder: (_) => locator<SearchHistoriesModel>(),
        child: Consumer<SearchHistoriesModel>(
          builder: (_, model, __) => AppBar(
            title: Text(title),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: _PlayerSearchDelegate(model.histories));
                },
              ),
            ],
          ),
        ),
      );
}

/// SearchDelegate for searching player data
class _PlayerSearchDelegate extends SearchDelegate {
  /// List of search histories
  final List<String> histories;

  /// Constructor
  _PlayerSearchDelegate(this.histories);

  @override
  Widget buildSuggestions(BuildContext context) => Container();

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  List<Widget> buildActions(BuildContext context) => <Widget>[
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            // Clear the typed search string
            query = '';
          },
        ),
      ];
}
