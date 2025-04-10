import 'dart:async';
import 'package:salon_provider/config/auth_config.dart';
import 'package:salon_provider/screens/app_pages_screens/profile_detail_screen/layouts/selection_option_layout.dart';
import 'package:flutter/cupertino.dart';
import '../../config.dart';
import '../../model/response/user_response.dart';
import '../../model/request/update_profile.dart';
import '../../repositories/user_repository.dart';
import 'package:provider/provider.dart';
// import '../../screens/app_pages_screens/add_serviceman_screen/layouts/selection_option_layout.dart';

class ProfileDetailProvider with ChangeNotifier {
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  String dialCode = '+91';
  final FocusNode firstNameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  XFile? imageFile;
  SharedPreferences? preferences;
  UserResponse? user;
  final UserRepository _userRepository = UserRepository();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void initWithUser(UserResponse userResponse) {
    user = userResponse;
    txtFirstName.text = user?.firstname ?? "";
    txtLastName.text = user?.lastname ?? "";
    txtEmail.text = user?.email ?? "";
    txtPhone.text = user?.phoneNumber ?? "";

    notifyListeners();
  }

  Future<void> updateProfile(context) async {
    try {
      _isLoading = true;
      notifyListeners();

      final updateRequest = UpdateProfileRequestModel(
        firstname: txtFirstName.text,
        lastname: txtLastName.text,
        phoneNumber: txtPhone.text,
      );

      final userId = await AuthConfig.getUserId();
      if (userId == null) {
        onUpdateError(context);
        return;
      }

      final success = await _userRepository.updateUserProfile(
        userId,
        updateRequest,
        imageFile: imageFile,
      );

      if (success) {
        // Reset image file after successful update
        imageFile = null;
        // Refresh user data after successful update
        final updatedUser = await _userRepository.getUser();
        // Update local state
        initWithUser(updatedUser);
        // Update profile screen state
        final profileProvider =
            Provider.of<ProfileProvider>(context, listen: false);
        await profileProvider.refreshProfile();
        onUpdateSuccess(context);
      } else {
        onUpdateError(context);
      }
    } catch (e) {
      onUpdateError(context);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void onUpdateSuccess(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialogCommon(
            title: appFonts.updateSuccessfully,
            height: Sizes.s140,
            image: eGifAssets.successGif,
            subtext: language(context, appFonts.hurrayUpdateProfile),
            bText1: language(context, appFonts.okay),
            b1OnTap: () => route.pop(context)));
  }

  void onUpdateError(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialogCommon(
            title: appFonts.errorOccur,
            height: Sizes.s140,
            image: eGifAssets.successGif,
            subtext: language(context, appFonts.tryAgain),
            bText1: language(context, appFonts.okay),
            b1OnTap: () => route.pop(context)));
  }

  var selectList = [
    {"image": eSvgAssets.gallery, "title": appFonts.chooseFromGallery},
    {"image": eSvgAssets.camera, "title": appFonts.openCamera}
  ];

  changeDialCode(CountryCodeCustom country) {
    dialCode = country.dialCode!;
    notifyListeners();
  }

// GET IMAGE FROM GALLERY
  Future getImage(context, source) async {
    final ImagePicker picker = ImagePicker();
    imageFile = await picker.pickImage(source: source);
    notifyListeners();
    if (imageFile != null) {
      route.pop(context);
    }
  }

  showLayout(context) async {
    showDialog(
      context: context,
      builder: (context1) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppRadius.r12))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(language(context, appFonts.selectOne),
                    style: appCss.dmDenseBold18
                        .textColor(appColor(context).appTheme.darkText)),
                const Icon(CupertinoIcons.multiply)
              ]),
              const VSpace(Sizes.s20),
              ...appArray.selectList
                  .asMap()
                  .entries
                  .map((e) => SelectOptionLayout(
                      data: e.value,
                      index: e.key,
                      list: appArray.selectList,
                      onTap: () {
                        if (e.key == 0) {
                          getImage(context, ImageSource.gallery);
                        } else {
                          getImage(context, ImageSource.camera);
                        }
                      }))
                  .toList()
            ],
          ),
        );
      },
    );
  }
}
