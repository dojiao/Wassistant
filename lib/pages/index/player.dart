import 'package:flutter/material.dart';
import 'package:wassistant/pages/profile.dart';

/// Player page
class PlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Player page',
              style: Theme.of(context).textTheme.display1,
            ),
            RaisedButton(
              child: Text('Profile'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ProfilePage()),
                );
              },
            ),
          ],
        ),
      );
}
