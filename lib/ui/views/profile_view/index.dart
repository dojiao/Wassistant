import 'package:flutter/material.dart';

/// Profile view
class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('Profile page'),
            ],
          ),
        ),
      );
}
