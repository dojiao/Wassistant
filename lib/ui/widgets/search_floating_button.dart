import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/storage_keys.dart';
import '../../core/exceptions/http_exception.dart';
import '../../core/view_models/search_model.dart';

/// Floating action button for searching
class SearchFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<SearchModel>(
        builder: (_, search, __) => SpeedDial(
          animatedIcon: AnimatedIcons.search_ellipsis,
          tooltip: 'Search',
          elevation: 3.0,
          children: [
            SpeedDialChild(
              backgroundColor: Colors.red,
              child: Icon(
                Icons.flag,
              ),
            ),
            SpeedDialChild(
              backgroundColor: Colors.green,
              child: Icon(
                Icons.person,
              ),
              onTap: () async {
                var prefs = await SharedPreferences.getInstance();
                await showSearch(
                  context: context,
                  delegate: _PlayerSearchDelegate(prefs, search),
                );
              },
            ),
          ],
        ),
      );
}

class _PlayerSearchDelegate extends SearchDelegate {
  /// Instance of locator
  SharedPreferences _prefs;

  /// Instance of search model
  SearchModel search;

  // Constructor
  _PlayerSearchDelegate(this._prefs, this.search);

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
            // clear typed text and show suggestions
            query = '';
            showSuggestions(context);
          },
        ),
      ];

  @override
  Widget buildSuggestions(BuildContext context) {
    // filter history list with query
    var _histories = _prefs.getStringList(StorageKeys.playerHistory) ?? [];
    _histories = _histories.where((value) => value.contains(query)).toList();
    _histories = _histories.reversed.toList();

    // display history list
    return Container(
      child: ListView.builder(
        itemCount: _histories.length,
        itemBuilder: (_, index) => ListTile(
          leading: Icon(Icons.history),
          title: Text(_histories[index]),
          trailing: Transform.rotate(
            angle: -pi / 4,
            child: Icon(Icons.arrow_upward),
          ),
          onTap: () {
            // set tapped text to query and do search
            query = _histories[index];
            showResults(context);
          },
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // if query is empty
    if (query.trim().isEmpty) {
      // returns an empty widget
      return Container();
    }

    // otherwise, add query to search history list
    var _histories = _prefs.getStringList(StorageKeys.playerHistory) ?? [];
    _histories.remove(query);
    _histories.add(query);
    _prefs.setStringList(StorageKeys.playerHistory, _histories);

    // and display fetched players;
    return FutureBuilder(
      future: search.fetchPlayers(query.trim()),
      builder: (_, snapshot) {
        // if still waiting for response
        if (snapshot.connectionState == ConnectionState.waiting) {
          // display indicator
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        // if some errors occurred, display the error message
        if (snapshot.hasError) {
          // TODO: Error handling
          // set default error message
          var message = 'An error has occurred. '
              '\nTry this action again. '
              'If the problem continues, please contact us.';

          // if it is the status code error
          var error = snapshot.error;
          if (error is StatusCodeException) {
            // replace to the specified message
            message = error.toString();
          }

          // display error message
          return _errorView(context, message);
        }

        // if result is empty
        if (search.players.isEmpty) {
          // display no results message
          return _errorView(context, 'No results for "${query.trim()}".');
        }

        // otherwise, display results with
        return Container(
          child: ListView.builder(
            itemCount: search.players.length + 1,
            itemBuilder: (context, index) {
              // display a title bar to show the total count
              if (index == 0) {
                return Container(
                  padding: EdgeInsets.all(12.0),
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Total: ${search.players.length}',
                        style: Theme.of(context).textTheme.subtitle.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                );
              }

              // and a list of players
              return Container(
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text(search.players[index - 1].nickname),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: Theme.of(context).textTheme.subtitle.fontSize,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  /// Returns a widget to display passed error message
  Widget _errorView(BuildContext context, String message) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.grey,
                  size: 90.0,
                ),
              ],
            ),
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  message,
                  style: Theme.of(context).textTheme.subhead.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ],
            ),
          ],
        ),
      );
}
