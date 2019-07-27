import 'package:flutter/material.dart';

/// Home page
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Home page',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      );
}
