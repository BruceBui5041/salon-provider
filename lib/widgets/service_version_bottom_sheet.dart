import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_provider/common/enum_value.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/model/response/service_version_response.dart';
import 'package:salon_provider/widgets/booking_status_layout.dart';

class ServiceVersionBottomSheet extends StatelessWidget {
  final List<ServiceVersion>? serviceVersionList;
  final ServiceVersion? currentVersion;
  final Function(ServiceVersion) onVersionSelected;

  const ServiceVersionBottomSheet({
    Key? key,
    required this.serviceVersionList,
    required this.currentVersion,
    required this.onVersionSelected,
  }) : super(key: key);

  String getPublishStatus(ServiceVersion? version) {
    if (version?.publishedDate == null) {
      return "Draft";
    }
    if (version?.status == ServiceVersionStatus.inactive.name &&
        version?.publishedDate != null) {
      return "Published";
    }

    return "Publishing";
  }

  Color colorCondition(String status, BuildContext context) {
    switch (status.toLowerCase()) {
      case 'draft':
        return appColor(context).appTheme.ongoing;
      case 'published':
        return appColor(context).appTheme.primary;
      case 'publishing':
        return appColor(context).appTheme.green;
      default:
        return appColor(context).appTheme.darkText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: Insets.i20,
        right: Insets.i20,
        top: AppRadius.r10,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: appColor(context).appTheme.fieldCardBg,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppRadius.r8),
          topRight: Radius.circular(AppRadius.r8),
        ),
      ),
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select version",
                style: appCss.dmDenseMedium16
                    .textColor(appColor(context).appTheme.darkText),
              ),
            ],
          ),
          const SizedBox(height: Insets.i10),
          Expanded(
            child: ListView.builder(
              itemCount: serviceVersionList?.length ?? 0,
              itemBuilder: (context, index) {
                final version = serviceVersionList![index];
                final isSelected = version.id == currentVersion?.id;

                String statusText = getPublishStatus(version);

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.r8),
                    color: isSelected
                        ? appColor(context).appTheme.primary.withOpacity(0.1)
                        : null,
                  ),
                  child: ListTile(
                    selected: isSelected,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.r8),
                    ),
                    leading: BookingStatusLayout(
                      title: statusText,
                      color: colorCondition(statusText.toLowerCase(), context),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            version.title ?? "",
                            style: appCss.dmDenseMedium14
                                .textColor(appColor(context).appTheme.darkText),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                        Text(
                          "${version.id}",
                          style: appCss.dmDenseRegular12
                              .textColor(appColor(context).appTheme.lightText),
                        ),
                      ],
                    ),
                    onTap: () {
                      onVersionSelected(version);
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
