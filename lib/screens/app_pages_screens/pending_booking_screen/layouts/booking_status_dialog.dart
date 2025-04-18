import 'package:flutter/cupertino.dart';
import 'package:salon_provider/providers/app_pages_provider/booking_status_provider.dart';
import 'package:salon_provider/model/response/notification_res.dart';
import '../../../../config.dart';

class BookingStatusDialog extends StatelessWidget {
  final String? bookingId;

  const BookingStatusDialog({
    super.key,
    this.bookingId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          BookingStatusProvider()..getBookingNotifications(bookingId),
      child: Consumer<BookingStatusProvider>(
        builder: (context, provider, _) {
          return SizedBox(
            height: Sizes.s470,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      language(context, appFonts.bookingStatus),
                      style: appCss.dmDenseMedium18.textColor(
                        appColor(context).appTheme.darkText,
                      ),
                    ),
                    const Icon(CupertinoIcons.multiply)
                        .inkWell(onTap: () => route.pop(context))
                  ],
                ).paddingSymmetric(horizontal: Insets.i20),
                const VSpace(Sizes.s25),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: Insets.i20),
                  padding: const EdgeInsets.symmetric(
                    horizontal: Insets.i15,
                    vertical: Insets.i12,
                  ),
                  decoration: BoxDecoration(
                    color: appColor(context).appTheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.r8),
                    border: Border.all(
                      color:
                          appColor(context).appTheme.primary.withOpacity(0.3),
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "• ${language(context, appFonts.bookingId)}",
                        style: appCss.dmDenseMedium14.textColor(
                          appColor(context).appTheme.primary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "#${bookingId ?? ''}",
                        style: appCss.dmDenseMedium14.textColor(
                          appColor(context).appTheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const VSpace(Sizes.s20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (provider.isLoading)
                          const CircularProgressIndicator()
                        else if (provider.error != null)
                          Text(provider.error!)
                        else if (provider.notifications.isEmpty)
                          Text(
                            'No status updates available',
                            style: appCss.dmDenseMedium14.textColor(
                              appColor(context).appTheme.lightText,
                            ),
                          )
                        else
                          ...provider.notifications
                              .asMap()
                              .entries
                              .map(
                                (e) => StatusStepsLayout(
                                  data: e.value,
                                  provider: provider,
                                  index: provider.selectedStatusIndex,
                                  selectIndex: provider.selectedStatusIndex,
                                  list: provider.notifications,
                                ),
                              )
                              .toList(),
                      ],
                    ).paddingSymmetric(horizontal: Insets.i20),
                  ),
                ),
              ],
            ).paddingSymmetric(vertical: Insets.i20),
          ).bottomSheetExtension(context);
        },
      ),
    );
  }
}
