import 'package:salon_provider/network/api.dart';
import 'package:salon_provider/network/api_config.dart';
import 'package:salon_provider/network/common_api.dart';
import 'package:salon_provider/providers/app_pages_provider/notification_provider.dart';
import 'package:salon_provider/providers/index.dart';
import 'package:salon_provider/repositories/add_new_service_repository.dart';
import 'package:salon_provider/repositories/edit_service_repository.dart';
import 'package:salon_provider/repositories/payment_repository.dart';
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
  getIt.registerLazySingleton(() => AuthApiClient(getIt()));
  getIt.registerLazySingleton(() => OtpApiClient(getIt()));
  getIt.registerLazySingleton(() => ServiceApiClient(getIt()));
  getIt.registerLazySingleton(() => PaymentApiClient(getIt()));
  getIt.registerLazySingleton(() => BookingApiClient(getIt()));
  getIt.registerLazySingleton(() => UserApiClient(getIt()));
  getIt.registerLazySingleton(() => CommonApi());

  // Add other modules here
  getIt.registerLazySingleton(() => LoginScreenRepository());
  getIt.registerLazySingleton(() => RegisterRepository());
  getIt.registerLazySingleton(() => AddNewServiceRepository());
  getIt.registerLazySingleton(() => VerifyOtpRepository());
  getIt.registerLazySingleton(() => BookingRepository());
  getIt.registerLazySingleton(() => PaymentRepository());
  getIt.registerLazySingleton(() => PopularServiceRepository());
  getIt.registerLazySingleton(() => AllServiceRepository());
  getIt.registerLazySingleton(() => EditServiceRepository());
  getIt.registerLazySingleton(() => TokenRepository());
  getIt.registerLazySingleton(() => UserRepository());
  getIt.registerLazySingleton(() => BookingProvider());
  getIt.registerLazySingleton(() => NotificationProvider());
  getIt.registerLazySingleton(() => AcceptedBookingProvider());
  getIt.registerLazySingleton(() => OngoingBookingProvider());
  getIt.registerLazySingleton(() => PendingBookingProvider());
  getIt.registerLazySingleton(() => AssignBookingProvider());
  getIt.registerLazySingleton(() => HoldBookingProvider());

  // getIt.registerLazySingleton(() => RegisterRepository());
  // getIt.registerLazySingleton(() => VerifyOtpRepository());
}
