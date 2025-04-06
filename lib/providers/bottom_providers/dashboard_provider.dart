import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/model/response/service_response.dart';
import 'package:salon_provider/repositories/popular_service_repository.dart';
import 'package:salon_provider/screens/bottom_screens/booking_screen/custom_booking_screen.dart';
import '../../model/blog_model.dart';

class DashboardProvider with ChangeNotifier {
  var repo = getIt.get<PopularServiceRepository>();
  int selectIndex = 0;
  List<BlogModel> blogList = [];
  TextEditingController searchCtrl = TextEditingController();
  FocusNode searchFocus = FocusNode();
  List<ItemService> serviceList = [];

  onReady() async {
    blogList = [];
    notifyListeners();
    appArray.blogList.asMap().entries.forEach((element) {
      if (!blogList.contains(BlogModel.fromJson(element.value))) {
        blogList.add(BlogModel.fromJson(element.value));
      }
    });
    await getService();
    notifyListeners();
  }

  getService() async {
    serviceList = [];
    notifyListeners();
    var res = await repo.getPopularService();
    if (res != null) {
      serviceList = res.data ?? [];
      notifyListeners();
    }
  }

  onTap(index) {
    selectIndex = index;
    notifyListeners();
  }

  onExpand(data) {
    data.isExpand = !data.isExpand;
    notifyListeners();
  }

  onAdd(context) {
    if (isFreelancer) {
      route.pushNamed(context, routeName.addNewService);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
              insetPadding: EdgeInsets.zero,
              /*contentPadding: const EdgeInsets.symmetric(
                  horizontal: Insets.i20, vertical: Insets.i15),*/
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppRadius.r8))),
              backgroundColor: appColor(context).appTheme.whiteBg,
              content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: appArray.dashBoardList
                      .asMap()
                      .entries
                      .map((e) => Column(children: [
                            Row(children: [
                              SizedBox(
                                      height: Sizes.s13,
                                      width: Sizes.s13,
                                      child:
                                          SvgPicture.asset(e.value["image"]!))
                                  .paddingAll(Insets.i4)
                                  .decorated(
                                      color: appColor(context)
                                          .appTheme
                                          .fieldCardBg,
                                      shape: BoxShape.circle),
                              const HSpace(Sizes.s12),
                              Text(language(context, e.value["title"]),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: appCss.dmDenseMedium12.textColor(
                                      appColor(context).appTheme.darkText))
                            ]),
                            if (e.key != appArray.dashBoardList.length - 1)
                              const DividerCommon()
                                  .paddingSymmetric(vertical: Insets.i15)
                          ]).inkWell(onTap: () {
                            if (e.key == 0) {
                              route.pop(context);
                              route.pushNamed(context, routeName.addNewService);
                            } else {
                              route.pop(context);
                              route.pushNamed(context, routeName.addServicemen);
                            }
                          }))
                      .toList())));
    }
  }

  final List<Widget> pages = [
    HomeScreen(),
    //NoInternetScreen(),
    // BookingScreen(),
    CustomBookingScreen(),
    WalletScreen(),
    ProfileScreen()
  ];
}
