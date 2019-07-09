import 'package:flutter/material.dart';

/// Settings page
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Settings page',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      );
}
