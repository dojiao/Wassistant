import 'package:get_it/get_it.dart';

import 'core/services/player_service.dart';
import 'core/view_models/page_model.dart';
import 'core/view_models/search_model.dart';

/// Instance of locator
GetIt locator = GetIt();

/// Setup locator
void setupLocator() {
  locator.registerLazySingleton(() => PlayerService());

  locator.registerFactory(() => PageModel());
  locator.registerFactory(() => SearchModel());
}
