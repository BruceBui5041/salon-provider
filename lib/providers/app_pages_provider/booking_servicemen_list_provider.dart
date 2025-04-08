import 'package:salon_provider/config.dart';

class BookingServicemenListProvider with ChangeNotifier {
  List selectCategory = [];

  TextEditingController searchCtrl = TextEditingController();
  FocusNode searchFocus = FocusNode();
  String? yearValue;
  int selectedIndex = 0;
  List selectedRates = [];
  bool isAvailable = false;
  int? required;
  String? amount;

  onReady(context) {
    dynamic data = ModalRoute.of(context)!.settings.arguments ?? "";

    if (data != null) {
      required = data["servicemen"];
      amount = data["amount"];
      notifyListeners();
    }
  }

  onClearTap(context) {
    route.pop(context);
    selectedRates = [];
    notifyListeners();
  }

  onTapSwitch(val) {
    isAvailable = val;
    notifyListeners();
  }

  onTapYear(val) {
    yearValue = val;
    notifyListeners();
  }

  onTapRating(id) {
    if (!selectedRates.contains(id)) {
      selectedRates.add(id);
    } else {
      selectedRates.remove(id);
    }
    notifyListeners();
  }

  onTapRadio(index) {
    selectedIndex = index;
    notifyListeners();
  }

  void onCategorySelected(index) {
    if (selectCategory.contains(index)) {
      selectCategory.remove(index); // unselect
    } else {
      selectCategory.add(index); // select
    }
    notifyListeners();
  }

  onTapFilter(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BookingServicemenListFilter();
      },
    );
  }

  onAssignBooking(context) {
    if (selectCategory.isNotEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context1) {
            return AlertDialogCommon(
                title: appFonts.assignToServicemen,
                subtext: appFonts.areYouSureServicemen,
                isBooked: true,
                isTwoButton: true,
                widget: Container(
                        alignment: Alignment.bottomCenter,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(alignment: Alignment.topRight, children: [
                          Image.asset(eImageAssets.assignServicemen,
                              height: Sizes.s145, width: Sizes.s130),
                          SizedBox(
                                  height: Sizes.s34,
                                  width: Sizes.s34,
                                  child: Image.asset(eGifAssets.tick,
                                      height: Sizes.s34, width: Sizes.s34))
                              .paddingOnly(top: Insets.i30)
                        ]))
                    .paddingOnly(top: Insets.i15)
                    .decorated(
                        color: appColor(context).appTheme.fieldCardBg,
                        borderRadius: BorderRadius.circular(AppRadius.r10)),
                height: Sizes.s145,
                firstBText: appFonts.cancel,
                firstBTap: () => route.pop(context1),
                secondBText: appFonts.yes,
                secondBTap: () {
                  route.pop(context);
                  route.pushNamed(context, routeName.assignBooking,
                      arg: {"bool": true, "amount": amount});
                });
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please select servicemen",
              style: appCss.dmDenseMedium14
                  .textColor(appColor(context).appTheme.whiteColor)),
          backgroundColor: appColor(context).appTheme.red,
          behavior: SnackBarBehavior.floating));
    }
  }
}
