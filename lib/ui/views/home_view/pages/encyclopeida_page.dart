import 'package:flutter/material.dart';

/// Settings page
class EncyclopediaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Encyclopedia'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Encyclopedia page',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      );
}
