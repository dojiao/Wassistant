import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassistant/core/constants/storage_keys.dart';
import 'package:wassistant/core/exceptions/http_exception.dart';
import 'package:wassistant/core/view_models/search_model.dart';

import 'search_results_view.dart';

/// Floating action bar for searching and drawer
class SearchFloatingBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SliverAppBar(
        // white background to match the theme
        // of widget created by showSearch()
        backgroundColor: Colors.white,
        floating: true,
        pinned: false,
        snap: false,
        elevation: 2.0,
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              // grey icon to match the theme
              // of widget created by showSearch()
              color: Colors.grey,
            ),
            onPressed: () => Scaffold.of(context).openDrawer()),
        title: TextField(
          autocorrect: true,
          // Material text design: headline6
          // to match the theme of widget created by showSearch()
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          decoration:
              InputDecoration(border: InputBorder.none, hintText: 'Search'),
          onTap: () async {
            var prefs = await SharedPreferences.getInstance();
            await showSearch(
              context: context,
              delegate: _PlayerSearch(prefs),
            );
          },
        ),
        // A mic button? Or nothing?
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(
        //       Icons.mic,
        //       color: Colors.grey,
        //     ),
        //     onPressed: () {},
        //   )
        // ],
      );
}

class _PlayerSearch extends SearchDelegate {
  /// Instance of locator
  SharedPreferences _prefs;

  /// Instance of search model
  SearchModel search = SearchModel();

  // Constructor
  _PlayerSearch(this._prefs);

  @override
  String get query => super.query.trim();

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () => Navigator.pop(context));

  @override
  List<Widget> buildActions(BuildContext context) => <Widget>[
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            // clear typed text and show suggestions
            query = '';
            showSuggestions(context);
          },
        ),
      ];

  @override
  Widget buildSuggestions(BuildContext context) {
    // filter history list with query
    var histories = _prefs.getStringList(StorageKeys.playerHistory) ?? [];
    histories = histories.where((value) => value.contains(query)).toList();
    histories = histories.reversed.toList();

    // display history list
    return Container(
      child: ListView.builder(
        itemCount: histories.length,
        itemBuilder: (_, index) => ListTile(
          leading: Icon(Icons.history),
          title: Text(histories[index]),
          trailing: Transform.rotate(
            angle: -pi / 4,
            child: Icon(Icons.arrow_upward),
          ),
          onTap: () {
            // set tapped text to query and do search
            query = histories[index];
            showResults(context);
          },
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // if query is empty
    if (query.isEmpty) {
      // returns an empty widget
      return Container();
    }

    // otherwise, add query to search history list
    var _histories = _prefs.getStringList(StorageKeys.playerHistory) ?? [];
    _histories.remove(query);
    _histories.add(query);
    _prefs.setStringList(StorageKeys.playerHistory, _histories);

    // and display fetched players;
    // We already have FutureBuilder so provider is useless.
    // Just use snapshot to access search results.
    return FutureBuilder(
      future: search.searchWith(query),
      builder: (context, snapshot) {
        // if still waiting for response
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          // display indicator
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        // if some errors occurred, display the error message
        if (snapshot.hasError) {
          // if it is the status code error or network error
          var error = snapshot.error;
          if (error is StatusCodeException || error is NetworkException) {
            // display error message
            return _showErrorView(context, error.toString());
          }

          // otherwise regarded as the unexpected error
          return _showErrorView(context, UnexpectedException().toString());
        }

        // if result is empty
        if (search.players.isEmpty) {
          // display no results message
          return _showErrorView(context, 'No results for "$query".');
        }

        // otherwise, display results
        return SearchResultsView(snapshot.data);
      },
    );
  }

  /// Returns a widget to display passed error message
  Widget _showErrorView(BuildContext context, String message) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Icon(
                Icons.error_outline,
                color: Colors.grey,
                size: 90.0,
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    message,
                    softWrap: true,
                    style: Theme.of(context).textTheme.subhead.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
