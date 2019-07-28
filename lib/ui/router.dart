import 'package:flutter/material.dart';

import '../core/constants/route_paths.dart';
import 'views/clan_detail_view/index.dart';
import 'views/home_view/index.dart';

/// Routing class
class Router {
  /// Generate routes
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final ViewArguments args = settings.arguments;

    switch (settings.name) {
      case RoutePaths.home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case RoutePaths.clanDetail:
        return MaterialPageRoute(builder: (_) => ClanDetailView(args.clanId));
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

/// The arguments of view
class ViewArguments {
  /// Clan id
  final int clanId;

  /// Returns a instance contains the arguments of views
  ViewArguments({this.clanId});
}
