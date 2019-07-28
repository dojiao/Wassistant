import 'package:flutter/material.dart';

import '../core/constants/route_paths.dart';
import 'views/clan_detail_view/index.dart';
import 'views/home_view/index.dart';

/// Routing class
class Router {
  /// Generate routes
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case RoutePaths.clanDetail:
        return MaterialPageRoute(builder: (_) => ClanDetailView());
      default:
        return MaterialPageRoute(
            // TODO: Need error page?
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
