import 'package:salon_provider/config/auth_config.dart';
import 'package:salon_provider/model/response/user_response.dart';
import 'package:salon_provider/model/response/address_res.dart';
import 'package:salon_provider/repositories/address_repository.dart';
import 'package:salon_provider/network/address_api.dart';
import 'package:dio/dio.dart';

import '../../../../config.dart';

class HomeAppBar extends StatefulWidget {
  final String? location;
  final GestureTapCallback? onTap;

  const HomeAppBar({super.key, this.location, this.onTap});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  UserResponse? userResponse;
  Address? currentAddress;

  Future<void> getData() async {
    userResponse = await AuthConfig.getUser();
    final addressRepository = AddressRepository(AddressApi(Dio()));
    currentAddress = await addressRepository.getCurrentAddress();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const HSpace(Sizes.s20),
                    Image.asset(eImageAssets.homeIcon,
                        height: Sizes.s40, width: Sizes.s40),
                    const HSpace(Sizes.s10),
                    InkWell(
                      onTap: () =>
                          route.pushNamed(context, routeName.selectLocation),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${userResponse?.firstname ?? ""} ${userResponse?.lastname ?? ""}",
                            style: appCss.dmDenseBold14
                                .textColor(appColor(context).appTheme.darkText),
                          ),
                          if (currentAddress?.text != null)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: Sizes.s12,
                                  color: appColor(context).appTheme.primary,
                                ),
                                const HSpace(Sizes.s4),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    currentAddress?.text ?? "",
                                    style: appCss.dmDenseRegular12.textColor(
                                        appColor(context).appTheme.lightText),
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(children: [
                  CommonArrow(arrow: eSvgAssets.chat).inkWell(
                      onTap: () =>
                          route.pushNamed(context, routeName.chatHistory)),
                  const HSpace(Sizes.s10),
                  Container(
                          alignment: Alignment.center,
                          height: Sizes.s40,
                          width: Sizes.s40,
                          child: Stack(alignment: Alignment.topRight, children: [
                            SvgPicture.asset(eSvgAssets.notification,
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                colorFilter: ColorFilter.mode(
                                    appColor(context).appTheme.darkText,
                                    BlendMode.srcIn)),
                            Positioned(
                                top: 2,
                                right: 2,
                                child: Icon(Icons.circle,
                                    size: Sizes.s7,
                                    color: appColor(context).appTheme.red))
                          ]))
                      .decorated(
                          shape: BoxShape.circle,
                          color: appColor(context).appTheme.fieldCardBg)
                      .inkWell(
                          onTap: () =>
                              route.pushNamed(context, routeName.notification))
                      .paddingOnly(
                          right: rtl(context) ? 0 : Insets.i20,
                          left: rtl(context) ? Insets.i20 : 0)
                ])
              ]);
        });
  }
}
