import 'package:salon_provider/config/constant_api_config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/config/storage_config.dart';
import 'package:salon_provider/helper/notification_helper.dart';
import 'package:salon_provider/providers/app_pages_provider/address_provider.dart';
import 'package:salon_provider/providers/app_pages_provider/all_service_provider.dart';
import 'package:salon_provider/providers/app_pages_provider/payment_qr_provider.dart';
import 'package:salon_provider/providers/app_pages_provider/service_details_provider.dart';
import 'package:salon_provider/providers/app_pages_provider/edit_service_provider.dart';
import 'package:salon_provider/providers/app_pages_provider/image_service_provider.dart';
import 'package:salon_provider/providers/auth_provider/register_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'firebase_options.dart';
import 'common/languages/app_language.dart';
import 'common/theme/app_theme.dart';
import 'config.dart';
import 'package:salon_provider/providers/app_pages_provider/home_screen_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ConstantApiConfig().init("DEV");
  await StorageConfig.init();
  await initInjector();
  await NotificationHelper().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, AsyncSnapshot<SharedPreferences> snapData) {
          if (snapData.hasData) {
            return MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                      create: (_) => ThemeService(snapData.data!)),
                  ChangeNotifierProvider(create: (_) => SplashProvider()),
                  ChangeNotifierProvider(
                      create: (_) => LanguageProvider(snapData.data!)),
                  ChangeNotifierProvider(
                      create: (_) => CurrencyProvider(snapData.data!)),
                  ChangeNotifierProvider(create: (_) => LoginAsProvider()),
                  ChangeNotifierProvider(create: (_) => LoadingProvider()),
                  ChangeNotifierProvider(
                      create: (_) => LoginAsServicemanProvider()),
                  ChangeNotifierProvider(
                      create: (_) => ForgetPasswordProvider()),
                  ChangeNotifierProvider(create: (_) => VerifyOtpProvider()),
                  ChangeNotifierProvider(
                      create: (_) => ResetPasswordProvider()),
                  ChangeNotifierProvider(create: (_) => IntroProvider()),
                  ChangeNotifierProvider(
                      create: (_) => SignUpCompanyProvider()),
                  ChangeNotifierProvider(create: (_) => LocationProvider()),
                  ChangeNotifierProvider(create: (_) => DashboardProvider()),
                  ChangeNotifierProvider(create: (_) => HomeProvider()),
                  ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
                  ChangeNotifierProvider(
                      create: (_) => EarningHistoryProvider()),
                  ChangeNotifierProvider(create: (_) => NotificationProvider()),
                  ChangeNotifierProvider(create: (_) => ServiceListProvider()),
                  ChangeNotifierProvider(
                      create: (_) => AddNewServiceProvider()),
                  ChangeNotifierProvider(
                      create: (_) => ServiceDetailsProviderOld()),
                  ChangeNotifierProvider(
                      create: (_) => ServiceReviewProvider()),
                  ChangeNotifierProvider(
                      create: (_) => CategoriesListProvider()),
                  ChangeNotifierProvider(
                      create: (_) => ServicemanListProvider()),
                  ChangeNotifierProvider(
                      create: (_) => AddServicemenProvider()),
                  ChangeNotifierProvider(
                      create: (_) => LatestBLogDetailsProvider()),
                  ChangeNotifierProvider(create: (_) => ProfileProvider()),
                  ChangeNotifierProvider(
                      create: (_) => ChangePasswordProvider()),
                  ChangeNotifierProvider(
                      create: (_) => CompanyDetailProvider()),
                  ChangeNotifierProvider(
                      create: (_) => AppSettingProvider(snapData.data!)),
                  ChangeNotifierProvider(
                      create: (_) => ProfileDetailProvider()),
                  ChangeNotifierProvider(create: (_) => BankDetailProvider()),
                  ChangeNotifierProvider(create: (_) => TimeSlotProvider()),
                  ChangeNotifierProvider(create: (_) => PackageListProvider()),
                  ChangeNotifierProvider(
                      create: (_) => PackageDetailProvider()),
                  ChangeNotifierProvider(create: (_) => AddPackageProvider()),
                  ChangeNotifierProvider(
                      create: (_) => SelectServiceProvider()),
                  ChangeNotifierProvider(
                      create: (_) => BookingDetailsProvider()),
                  ChangeNotifierProvider(
                      create: (_) => CommissionInfoProvider()),
                  ChangeNotifierProvider(create: (_) => PlanDetailsProvider()),
                  ChangeNotifierProvider(
                      create: (_) => SubscriptionPlanProvider()),
                  ChangeNotifierProvider(create: (_) => WalletProvider()),
                  ChangeNotifierProvider(create: (_) => NoInternetProvider()),
                  ChangeNotifierProvider(
                      create: (_) => AcceptedBookingProvider()),
                  ChangeNotifierProvider(
                      create: (_) => BookingServicemenListProvider()),
                  ChangeNotifierProvider(create: (_) => ChatProvider(getIt())),
                  ChangeNotifierProvider(
                      create: (_) => AssignBookingProvider()),
                  ChangeNotifierProvider(
                      create: (_) => PendingApprovalBookingProvider()),
                  ChangeNotifierProvider(
                      create: (_) => OngoingBookingProvider()),
                  ChangeNotifierProvider(
                      create: (_) => AddExtraChargesProvider()),
                  ChangeNotifierProvider(create: (_) => HoldBookingProvider()),
                  ChangeNotifierProvider(
                      create: (_) => CompletedBookingProvider()),
                  ChangeNotifierProvider(
                      create: (_) => AddServiceProofProvider()),
                  ChangeNotifierProvider(
                      create: (_) => CancelledBookingProvider(getIt())),
                  ChangeNotifierProvider(create: (_) => ChatHistoryProvider()),
                  ChangeNotifierProvider(create: (_) => DeleteDialogProvider()),
                  ChangeNotifierProvider(create: (_) => LocationListProvider()),
                  ChangeNotifierProvider(
                      create: (_) => ServicemenDetailProvider()),
                  ChangeNotifierProvider(create: (_) => NewLocationProvider()),
                  ChangeNotifierProvider(
                      create: (_) => IdVerificationProvider()),
                  ChangeNotifierProvider(
                      create: (_) => CommissionHistoryProvider()),
                  ChangeNotifierProvider(create: (_) => SearchProvider()),
                  ChangeNotifierProvider(create: (_) => ViewLocationProvider()),
                  ChangeNotifierProvider(create: (_) => RegisterProvider()),
                  ChangeNotifierProvider(create: (_) => AllServiceProvider()),
                  ChangeNotifierProvider(create: (_) => EditServiceProvider()),
                  ChangeNotifierProvider(create: (_) => BookingProvider()),
                  ChangeNotifierProvider(
                      create: (_) => PendingBookingProvider()),
                  ChangeNotifierProvider(
                      create: (_) => ServiceDetailsProvider()),
                  ChangeNotifierProvider(create: (_) => ImageServiceProvider()),
                  ChangeNotifierProvider(create: (_) => PaymentQrProvider()),
                  ChangeNotifierProvider(
                      create: (_) => AddressProvider(getIt(), getIt())),
                ],
                child: Consumer<ThemeService>(builder: (context, theme, child) {
                  return Consumer<LanguageProvider>(
                      builder: (context, lang, child) {
                    return Consumer<CurrencyProvider>(
                        builder: (context, currency, child) {
                      return MaterialApp(
                          title: 'MeoMeo Provider',
                          debugShowCheckedModeBanner: false,
                          theme: AppTheme.fromType(ThemeType.light).themeData,
                          darkTheme:
                              AppTheme.fromType(ThemeType.dark).themeData,
                          locale: lang.locale,
                          // locale: const Locale("en"),
                          localizationsDelegates: const [
                            AppLocalizations.delegate,
                            AppLocalizationDelagate(),
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate,
                            FlutterQuillLocalizations.delegate,
                          ],
                          supportedLocales: appArray.localList,
                          themeMode: theme.theme,
                          initialRoute: "/",
                          routes: appRoute.route);
                    });
                  });
                }));
          } else {
            return MaterialApp(
                theme: AppTheme.fromType(ThemeType.light).themeData,
                darkTheme: AppTheme.fromType(ThemeType.dark).themeData,
                themeMode: ThemeMode.light,
                debugShowCheckedModeBanner: false,
                home: const SplashLayout());
          }
        });
  }
}
