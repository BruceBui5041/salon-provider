import 'package:salon_provider/network/api.dart';
import 'package:salon_provider/network/api_config.dart';
import 'package:salon_provider/network/common_api.dart';
import 'package:salon_provider/repositories/add_new_service_repository.dart';
import 'package:salon_provider/repositories/edit_service_repository.dart';
import 'package:salon_provider/repositories/popular_service_repository.dart';
import 'package:salon_provider/repositories/login_repository.dart';
import 'package:salon_provider/repositories/register_repository.dart';
import 'package:salon_provider/repositories/token_repository.dart';
import 'package:salon_provider/repositories/verify_otp_repository.dart';
import 'package:salon_provider/repositories/booking_repository.dart';
import 'package:salon_provider/repositories/all_service_repository.dart';
import 'package:salon_provider/repositories/user_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initInjector() async {
  // Register core
  getIt.registerLazySingleton(() => ApiConfig.createDio());
  getIt.registerLazySingleton(() => RestClient(getIt()));
  getIt.registerLazySingleton(() => CommonApi());

  // Add other modules here
  getIt.registerLazySingleton(() => LoginScreenRepository());
  getIt.registerLazySingleton(() => RegisterRepository());
  getIt.registerLazySingleton(() => AddNewServiceRepository());
  getIt.registerLazySingleton(() => VerifyOtpRepository());
  getIt.registerLazySingleton(() => BookingRepository());
  getIt.registerLazySingleton(() => PopularServiceRepository());
  getIt.registerLazySingleton(() => AllServiceRepository());
  getIt.registerLazySingleton(() => EditServiceRepository());
  getIt.registerLazySingleton(() => TokenRepository());
  getIt.registerLazySingleton(() => UserRepository());

  // getIt.registerLazySingleton(() => RegisterRepository());
  // getIt.registerLazySingleton(() => VerifyOtpRepository());
}
