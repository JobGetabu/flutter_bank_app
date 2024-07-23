import 'package:core/blocs/top_up/top_up_cubit.dart';
import 'package:core/blocs/user_details/user_detail_cubit.dart';
import 'package:core/data/network/mock_user_service.dart';
import 'package:core/data/repositories/user_repository.dart';
import 'package:core/services/navigation_service.dart';
import 'package:dependencies/dependencies.dart';

GetIt inject = GetIt.instance;

Future<void> setUpLocator() async {
  // services
  _setUpServices();

  // repositories
  await _setUpRepositories();

  // blocs
  _setUpBlocs();
}

void _setUpServices() {
  inject.registerSingleton(NavigationService());
  inject.registerLazySingleton<ApiService>(() => MockUserService());
}

Future<void> _setUpRepositories() async {
  inject.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(apiService: inject()));
}

Future<void> _setUpBlocs() async {
  inject.registerFactory<UserDetailCubit>(
    () => UserDetailCubit(
      userRepository: inject(),
    ),
  );

  inject.registerFactory<TopUpCubit>(
    () => TopUpCubit(
      userRepository: inject(),
    ),
  );
}
