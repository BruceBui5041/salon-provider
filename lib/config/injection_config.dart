import 'package:fixit_provider/network/api.dart';
import 'package:fixit_provider/network/api_config.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initInjector() async {
  // Register core
  getIt.registerLazySingleton(() => ApiConfig.createDio());
  getIt.registerLazySingleton(() => RestClient(getIt()));

  // Add other modules here
  // getIt.registerLazySingleton(() => LoginScreenRepository());
  // getIt.registerLazySingleton(() => RegisterRepository());
  // getIt.registerLazySingleton(() => VerifyOtpRepository());
}
