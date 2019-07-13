import 'package:get_it/get_it.dart';

import 'core/view_models/page_model.dart';
import 'core/view_models/widgets/search_histories_model.dart';

/// Instance of locator
GetIt locator = GetIt();

/// Setup locator
void setupLocator() {
  locator.registerLazySingleton(() => PageModel());
  locator.registerLazySingleton(() => SearchHistoriesModel());
}
