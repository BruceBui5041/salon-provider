import 'package:fixit_provider/network/api.dart';
import 'package:fixit_provider/network/api_config.dart';
import 'package:fixit_provider/network/common_api.dart';
import 'package:fixit_provider/screens/app_pages_screens/add_new_service_screen/repository/add_new_service_repository.dart';
import 'package:fixit_provider/screens/app_pages_screens/edit_service_screen/repository/edit_service_repository.dart';
import 'package:fixit_provider/screens/app_pages_screens/popular_service_screen/repository/popular_service_repository.dart';
import 'package:fixit_provider/screens/auth_screens/login_as_provider_screen/repository/login_repository.dart';
import 'package:fixit_provider/screens/auth_screens/register_screen/repository/register_repository.dart';
import 'package:fixit_provider/screens/auth_screens/verify_otp_screen/repository/verify_otp_repository.dart';
import 'package:fixit_provider/screens/bottom_screens/booking_screen/repository/booking_repository.dart';
import 'package:fixit_provider/screens/bottom_screens/home_screen/repository/all_service_repository.dart';
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

  // getIt.registerLazySingleton(() => RegisterRepository());
  // getIt.registerLazySingleton(() => VerifyOtpRepository());
}
