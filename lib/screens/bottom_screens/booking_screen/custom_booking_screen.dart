import 'package:salon_provider/providers/bottom_providers/custom_booking_provider.dart';
import 'package:salon_provider/screens/bottom_screens/booking_screen/layouts/custom_booking_layout.dart';

import '../../../config.dart';

class CustomBookingScreen extends StatelessWidget {
  const CustomBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomBookingProvider>(
      builder: (context, bookingProvider, _) {
        return StatefulWrapper(
          onInit: () => _initializeBookingScreen(context, bookingProvider),
          child: Scaffold(
            backgroundColor: Colors.grey.shade300,
            appBar: _buildAppBar(context, bookingProvider),
            body: _buildBody(context, bookingProvider),
          ),
        );
      },
    );
  }

  Future<void> _initializeBookingScreen(
      BuildContext context, CustomBookingProvider provider) async {
    await Future.delayed(
      const Duration(milliseconds: 50),
      () => provider.onReady(context),
    );
  }

  PreferredSizeWidget _buildAppBar(
      BuildContext context, CustomBookingProvider provider) {
    return AppBar(
      leadingWidth: 0,
      centerTitle: false,
      title: Text(
        language(context, appFonts.bookings),
        style:
            appCss.dmDenseBold18.textColor(appColor(context).appTheme.darkText),
      ),
      actions: [
        Stack(
          children: [
            _buildActionButton(
              icon: eSvgAssets.filter,
              onTap: () => provider.onTapFilter(context),
              color: provider.hasActiveFilters
                  ? appColor(context).appTheme.primary
                  : appColor(context).appTheme.fieldCardBg,
              svgColor: provider.hasActiveFilters
                  ? appColor(context).appTheme.whiteColor
                  : appColor(context).appTheme.darkText,
            ),
            if (provider.hasActiveFilters)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: Sizes.s10,
                  height: Sizes.s10,
                  decoration: BoxDecoration(
                    color: appColor(context).appTheme.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        _buildActionButton(
          icon: eSvgAssets.chat,
          onTap: () => route.pushNamed(context, routeName.chat),
        ).paddingSymmetric(horizontal: Insets.i10),
        _buildActionButton(
          icon: eSvgAssets.notification,
          onTap: () => route.pushNamed(context, routeName.notification),
        ),
        const HSpace(Sizes.s20),
      ],
    );
  }

  Widget _buildActionButton({
    required String icon,
    required VoidCallback onTap,
    Color? color,
    Color? svgColor,
  }) {
    return CommonArrow(
      arrow: icon,
      onTap: onTap,
      color: color,
      svgColor: svgColor,
    );
  }

  Widget _buildBody(BuildContext context, CustomBookingProvider provider) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchField(provider),
          _buildAllBookingsHeader(context),
          if (isFreelancer != true) _buildAssignMeSwitch(context, provider),
          if (provider.isProcessing)
            const Center(
              child: CircularProgressIndicator(),
            ).paddingSymmetric(vertical: Insets.i50)
          else if (provider.bookingList.isNotEmpty ||
              provider.freelancerBookingList.isNotEmpty)
            _buildBookingList(context, provider)
          else
            _buildEmptyState(context),
        ],
      ).padding(
        horizontal: Insets.i20,
        top: Insets.i15,
        bottom: Insets.i100,
      ),
    );
  }

  Widget _buildSearchField(CustomBookingProvider provider) {
    return SearchTextFieldCommon(
      focusNode: provider.searchFocus,
      controller: provider.searchCtrl,
    );
  }

  Widget _buildAllBookingsHeader(BuildContext context) {
    return Text(
      language(context, appFonts.allBooking),
      style: appCss.dmDenseMedium18.textColor(
        appColor(context).appTheme.darkText,
      ),
    ).paddingOnly(top: Insets.i25, bottom: Insets.i15);
  }

  Widget _buildAssignMeSwitch(
      BuildContext context, CustomBookingProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: Sizes.s200,
          child: Text(
            language(context, appFonts.onlyViewBookings),
            style: appCss.dmDenseMedium12.textColor(
              provider.isAssignMe
                  ? appColor(context).appTheme.primary
                  : appColor(context).appTheme.darkText,
            ),
          ),
        ),
        FlutterSwitchCommon(
          value: provider.isAssignMe,
          onToggle: (val) => provider.onTapSwitch(val),
        ),
      ],
    )
        .paddingAll(Insets.i15)
        .boxShapeExtension(
          color: provider.isAssignMe
              ? appColor(context).appTheme.primary.withOpacity(0.15)
              : appColor(context).appTheme.fieldCardBg,
          radius: AppRadius.r10,
        )
        .paddingOnly(bottom: Insets.i20);
  }

  Widget _buildBookingList(
      BuildContext context, CustomBookingProvider provider) {
    final bookings =
        isFreelancer ? provider.freelancerBookingList : provider.bookingList;

    return Column(
      children: bookings
          .asMap()
          .entries
          .map(
            (e) => CustomBookingLayout(
              data: e.value,
              onTap: () {
                provider.onTapBookings(e.value, context);
              },
              onAccept: () {
                // provider.onAcceptBooking(e.value, context);
              },
              onReject: () {
                // provider.onRejectBooking(e.value, context);
              },
            ),
          )
          .toList(),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return EmptyLayout(
      isButton: false,
      title: appFonts.ohhNoListEmpty,
      subtitle: appFonts.yourBookingList,
      widget: Stack(
        children: [
          Image.asset(
            isFreelancer ? eImageAssets.noListFree : eImageAssets.noBooking,
            height: Sizes.s306,
          ),
        ],
      ),
    );
  }
}
