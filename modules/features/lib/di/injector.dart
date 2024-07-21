
import 'package:dependencies/dependencies.dart';

import '../services/navigation_service.dart';

GetIt inject = GetIt.instance;

void _setUpServices() {
  inject.registerSingleton(NavigationService());
}