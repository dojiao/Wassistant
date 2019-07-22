import 'package:flutter/material.dart';

import 'core/constants/route_paths.dart';
import 'locator.dart';
import 'ui/router.dart';

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
        initialRoute: RoutePaths.home,
        onGenerateRoute: Router.generateRoute,
        debugShowCheckedModeBanner: false,
      );
}
