import 'package:get_it/get_it.dart';

import 'core/view_model/page_model.dart';

/// Instance of locator
GetIt locator = GetIt();

/// Setup locator
void setupLocator() {
  locator.registerLazySingleton(() => PageModel());
}
