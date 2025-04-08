import 'package:figma_squircle_updated/figma_squircle.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/storage_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:salon_provider/model/response/user_response.dart';
import 'package:salon_provider/repositories/user_repository.dart';

class ProfileProvider with ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  UserResponse? _user;
  bool _isLoading = false;
  String? _error;
  List<ProfileModel> profileLists = [];

  dynamic timeSlot;

  UserResponse? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  onReady() async {
    profileLists =
        appArray.profileList.map((e) => ProfileModel.fromJson(e)).toList();
    await fetchUser();
    notifyListeners();
  }

  Future<void> fetchUser() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _userRepository.getUser();
      _user = response;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  onDeleteAccount(context, sync) {
    final value = Provider.of<DeleteDialogProvider>(context, listen: false);
    value.onDeleteAccount(sync, context);
    value.notifyListeners();
  }

  onLogout(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: Insets.i20),
          contentPadding: EdgeInsets.zero,
          shape: const SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius.all(SmoothRadius(
                  cornerRadius: AppRadius.r14, cornerSmoothing: 1))),
          backgroundColor: appColor(context).appTheme.whiteBg,
          content: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(language(context, appFonts.areYouSure),
                      style: appCss.dmDenseMedium16
                          .textColor(appColor(context).appTheme.darkText)),
                  const VSpace(Sizes.s20),
                  Row(children: [
                    Expanded(
                        child: ButtonCommon(
                            onTap: () => route.pop(context),
                            title: appFonts.cancel,
                            borderColor: appColor(context).appTheme.red,
                            color: appColor(context).appTheme.whiteBg,
                            style: appCss.dmDenseSemiBold16
                                .textColor(appColor(context).appTheme.red))),
                    const HSpace(Sizes.s15),
                    Expanded(
                        child: ButtonCommon(
                            color: appColor(context).appTheme.red,
                            onTap: () async {
                              final loginProvider =
                                  Provider.of<LoginAsProvider>(
                                context,
                                listen: false,
                              );
                              await loginProvider.logoutUser();

                              route.pushNamedAndRemoveUntil(
                                  context, routeName.intro);
                            },
                            title: appFonts.yes))
                  ])
                ],
              ).padding(
                  horizontal: Insets.i20, top: Insets.i60, bottom: Insets.i20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                // Title
                Text(language(context, appFonts.logOut),
                    style: appCss.dmDenseExtraBold18
                        .textColor(appColor(context).appTheme.darkText)),
                Icon(CupertinoIcons.multiply,
                        size: Sizes.s20,
                        color: appColor(context).appTheme.darkText)
                    .inkWell(onTap: () => route.pop(context))
              ]).paddingAll(Insets.i20)
            ],
          ),
        );
      },
    );
  }

  onTapOption(data, context, sync) {
    if (data.title == appFonts.companyDetails) {
      route.pushNamed(context, routeName.companyDetails);
    } else if (data.title == appFonts.bankDetails) {
      route.pushNamed(context, routeName.bankDetails);
    } else if (data.title == appFonts.idVerification) {
      route.pushNamed(context, routeName.idVerification);
    } else if (data.title == appFonts.timeSlots) {
      route.pushNamed(context, routeName.timeSlot);
    } else if (data.title == appFonts.myPackages) {
      route.pushNamed(context, routeName.packagesList);
    } else if (data.title == appFonts.commissionDetails) {
      route.pushNamed(context, routeName.commissionHistory);
    } else if (data.title == appFonts.myReview) {
      route.pushNamed(context, routeName.serviceReview, arg: true);
    } else if (data.title == appFonts.subscriptionPlan) {
      route.pushNamed(context, routeName.planDetails);
    } else if (data.title == appFonts.deleteAccount) {
      onDeleteAccount(context, sync);
      notifyListeners();
    } else {
      onLogout(context);
    }
  }
}
