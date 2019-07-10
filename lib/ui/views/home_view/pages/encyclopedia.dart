import 'package:flutter/material.dart';

/// Encyclopedia page
class EncyclopediaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Column(
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
