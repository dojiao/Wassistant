import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
            onTap: () => showSearch(
              context: context,
              delegate: _PlayerSearchDelegate(),
            ),
          ),
        ],
      );
}

class _PlayerSearchDelegate extends SearchDelegate {
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

  @override
  Widget buildSuggestions(BuildContext context) => Container();

  @override
  Widget buildResults(BuildContext context) => Container();
}
