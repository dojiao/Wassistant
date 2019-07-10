import 'package:flutter/material.dart';

import 'locator.dart';
import 'ui/views/home_view/index.dart';

void main() {
  setupLocator();
  runApp(Wassistant());
}

/// Main class
class Wassistant extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Wassistant',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeView(),
      );
}
