import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/storage_keys.dart';

/// Floating action button for searching
class SearchFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SpeedDial(
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
                delegate: _PlayerSearchDelegate(prefs),
              );
            },
          ),
        ],
      );
}

class _PlayerSearchDelegate extends SearchDelegate {
  /// Instance of locator
  SharedPreferences _prefs;

  // Constructor
  _PlayerSearchDelegate(this._prefs);

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
    var _histories = _prefs.getStringList(StorageKeys.playerHistory);
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
    if (query.trim().isEmpty) {
      return Container();
    }

    // add query to search history list
    var _histories = _prefs.getStringList(StorageKeys.playerHistory);
    _histories.remove(query);
    _histories.add(query);
    _prefs.setStringList(StorageKeys.playerHistory, _histories);

    return Container();
  }
}
