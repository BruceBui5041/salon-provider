import 'package:fixit_provider/screens/auth_screens/register_screen/register_screen.dart';

import '../config.dart';

class AppRoute {
  Map<String, Widget Function(BuildContext)> route = {
    routeName.splash: (p0) => SplashScreen(),
    routeName.intro: (p0) => IntroScreen(),
    routeName.loginProvider: (p0) => LoginAsProviderScreen(),
    routeName.loginServiceman: (p0) => LoginAsServicemanScreen(),
    routeName.forgetPassword: (p0) => ForgotPasswordScreen(),
    routeName.verifyOtp: (p0) => VerifyOtpScreen(),
    routeName.resetPass: (p0) => ResetPasswordScreen(),
    routeName.signUpCompany: (p0) => SignUpCompanyScreen(),
    routeName.location: (p0) => CurrentLocationScreen(),
    routeName.dashboard: (p0) => DashboardScreen(),
    routeName.earningHistory: (p0) => EarningHistoryScreen(),
    routeName.notification: (p0) => NotificationScreen(),
    routeName.serviceList: (p0) => ServiceListScreen(),
    routeName.addNewService: (p0) => AddNewServiceScreen(),
    routeName.serviceDetails: (p0) => ServicesDetailsScreen(),
    routeName.serviceReview: (p0) => ServiceReviewScreen(),
    routeName.locationList: (p0) => LocationListScreen(),
    routeName.categories: (p0) => CategoriesListScreen(),
    routeName.servicemanList: (p0) => ServicemanListScreen(),
    routeName.servicemanDetail: (p0) => ServicemanDetailScreen(),
    routeName.addServicemen: (p0) => AddServicemenScreen(),
    routeName.latestBlogDetails: (p0) => LatestBlogDetailsScreen(),
    routeName.latestBlogViewAll: (p0) => LatestBlogViewAll(),
    routeName.popularServiceScreen: (p0) => PopularServiceScreen(),
    routeName.appSetting: (p0) => AppSettingScreen(),
    routeName.changePassword: (p0) => ChangePasswordScreen(),
    routeName.changeLanguage: (p0) => ChangeLanguageScreen(),
    routeName.companyDetails: (p0) => CompanyDetailsScreen(),
    routeName.profileDetails: (p0) => ProfileDetailScreen(),
    routeName.bankDetails: (p0) => BankDetailScreen(),
    routeName.idVerification: (p0) => IdVerificationScreen(),
    routeName.timeSlot: (p0) => TimeSlotScreen(),
    routeName.packagesList: (p0) => PackagesListScreen(),
    routeName.packageDetails: (p0) => PackageDetailsScreen(),
    routeName.appPackage: (p0) => AddPackageScreen(),
    routeName.selectService: (p0) => SelectServiceScreen(),
    routeName.commissionHistory: (p0) => CommissionHistory(),
    routeName.bookingDetails: (p0) => BookingDetailsScreen(),
    routeName.commissionInfo: (p0) => CommissionInfoScreen(),
    routeName.commissionDetail: (p0) => CommissionDetailScreen(),
    routeName.providerReview: (p0) => ProviderReviewScreen(),
    routeName.planDetails: (p0) => PlanDetailsScreen(),
    routeName.subscriptionPlan: (p0) => SubscriptionPlanScreen(),
    routeName.pendingBooking: (p0) => PendingBookingScreen(),
    routeName.acceptedBooking: (p0) => AcceptBookingScreen(),
    routeName.bookingServicemenList: (p0) => BookingServicemenListScreen(),
    routeName.chat: (p0) => ChatScreen(),
    routeName.assignBooking: (p0) => AssignBookingScreen(),
    routeName.pendingApprovalBooking: (p0) => PendingApprovalBookingScreen(),
    routeName.ongoingBooking: (p0) => OngoingBookingScreen(),
    routeName.addExtraCharges: (p0) => AddExtraChargeScreen(),
    routeName.holdBooking: (p0) => HoldBookingScreen(),
    routeName.completedBooking: (p0) => CompletedBookingScreen(),
    routeName.addServiceProof: (p0) => AddServiceProofScreen(),
    routeName.cancelledBooking: (p0) => CancelledBookingScreen(),
    routeName.earnings: (p0) => EarningScreen(),
    routeName.chatHistory: (p0) => ChatHistoryScreen(),
    routeName.addNewLocation: (p0) => AddNewLocation(),
    routeName.signUpFreelancer: (p0) => SignupFreelancerScreen(),
    routeName.search: (p0) => SearchScreen(),
    routeName.viewLocation: (p0) => ViewLocationScreen(),
    routeName.registerScreen: (p0) => RegisterScreen(),
  };
}
