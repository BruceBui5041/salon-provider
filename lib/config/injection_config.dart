import 'package:fixit_provider/network/api.dart';
import 'package:fixit_provider/network/api_config.dart';
import 'package:fixit_provider/network/common_api.dart';
import 'package:fixit_provider/screens/app_pages_screens/add_new_service_screen/repository/add_new_service_repository.dart';
import 'package:fixit_provider/screens/auth_screens/login_as_provider_screen/repository/login_repository.dart';
import 'package:fixit_provider/screens/auth_screens/register_screen/repository/register_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initInjector() async {
  // Register core
  getIt.registerLazySingleton(() => ApiConfig.createDio());
  getIt.registerLazySingleton(() => RestClient(getIt()));

  // Add other modules here
  getIt.registerLazySingleton(() => LoginScreenRepository());
  getIt.registerLazySingleton(() => RegisterRepository());
  getIt.registerLazySingleton(() => AddNewServiceRepository());
  getIt.registerLazySingleton(() => CommonApi());
  // getIt.registerLazySingleton(() => RegisterRepository());
  // getIt.registerLazySingleton(() => VerifyOtpRepository());
}
