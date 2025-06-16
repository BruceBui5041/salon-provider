import 'package:salon_provider/common/enum_value.dart';
import 'package:salon_provider/model/response/service_version_response.dart';
import 'package:salon_provider/providers/app_pages_provider/all_service_provider.dart';
import 'package:salon_provider/providers/app_pages_provider/image_service_provider.dart';
import 'package:salon_provider/widgets/custom_drop_down_common.dart';

import '../../../config.dart';

class AddNewServiceScreen extends StatefulWidget {
  const AddNewServiceScreen({super.key});

  @override
  State<AddNewServiceScreen> createState() => _AddNewServiceScreenState();
}

class _AddNewServiceScreenState extends State<AddNewServiceScreen> {
  @override
  void initState() {
    Provider.of<AddNewServiceProvider>(context, listen: false).fetchCategory();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AddNewServiceProvider>(context, listen: false).clearInput();
    });
    super.dispose();
  }

  String getPublishStatus(AddNewServiceProvider value,
      {ServiceVersion? version}) {
    ServiceVersion? serviceVersion = version ?? value.serviceVersionSelected;

    if (serviceVersion?.isDraft() == true) {
      return language(context, appFonts.draft);
    }
    if (serviceVersion?.publishedDate != null) {
      return language(context, appFonts.published);
    }

    return language(context, appFonts.publishing);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewServiceProvider>(builder: (context1, value, child) {
      return StatefulWrapper(
          onDispose: () {
            Provider.of<AddNewServiceProvider>(context, listen: false)
                .clearInput();
          },
          onInit: () => Future.delayed(
                const Duration(milliseconds: 20),
                () => value.onReady(
                  context,
                ),
              ),
          child: PopScope(
            canPop: true,
            onPopInvoked: (bool? didPop) => value.onBack(),
            child: Scaffold(
              appBar: value.isEdit
                  ? AppBar(
                      leadingWidth: 80,
                      title: GestureDetector(
                        onTap: () => _buildModalBottomSheet(value),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                BookingStatusLayout(
                                  title: getPublishStatus(value),
                                  color: colorCondition(
                                      getPublishStatus(value).toLowerCase(),
                                      context),
                                ),
                                const SizedBox(width: Insets.i10),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        value.serviceSelected?.serviceVersion!
                                                .title ??
                                            "",
                                        style: appCss.dmDenseMedium16.textColor(
                                            appColor(context)
                                                .appTheme
                                                .darkText),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "${value.serviceSelected?.serviceVersion!.id ?? ""}",
                                        style: appCss.dmDenseRegular12
                                            .textColor(appColor(context)
                                                .appTheme
                                                .lightText),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      centerTitle: true,
                      leading: CommonArrow(
                              arrow: rtl(context)
                                  ? eSvgAssets.arrowRight
                                  : eSvgAssets.arrowLeft,
                              onTap: () => value.onBackButton(context))
                          .padding(vertical: Insets.i8),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: Insets.i20),
                          child: GestureDetector(
                            onTap: () {
                              //
                            },
                            child: CommonArrow(
                              color: appColor(context)
                                  .appTheme
                                  .red
                                  .withOpacity(0.3),
                              arrow: eSvgAssets.delete,
                              svgColor: Colors.red,
                              onTap: () => _buildModalBottomSheet(value),
                            ),
                          ),
                        ),
                      ],
                    )
                  : AppBarCommon(
                      actions: [],
                      title: appFonts.addNewService,
                      onTap: () => value.onBackButton(context),
                    ),
              body: value.isLoadingData == true
                  ? const Center(child: CircularProgressIndicator())
                  : value.isEdit
                      ? _bodyEdit(value)
                      : _bodyAddNew(value),
            ),
          ));
    });
  }

  Widget _bodyAddNew(AddNewServiceProvider value) {
    return Padding(
      padding: const EdgeInsets.all(Insets.i20),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                if (value.isEdit) _toolEdit(value),
                const FormServiceImageLayout(),
                const FormCategoryLayout(),
                const FormPriceLayout(),
                const SizedBox(height: 20),
              ],
            ),
          ),
          ButtonCommon(
            title: value.isEdit ? appFonts.update : appFonts.addService,
            onTap: () {
              value.addService(context, callBack: () {
                showDialog(
                  context: context,
                  builder: (context) => AppAlertDialogCommon(
                    image: eSvgAssets.service,
                    title: "Success",
                    subtext: "Service added successfully",
                    singleText: "OK",
                    firstBText: "Cancel",
                    secondBText: "OK",
                    focusNode: FocusNode(),
                    firstBTap: () {
                      Navigator.of(context).pop();
                    },
                    secondBTap: () {
                      Navigator.of(context).pop();
                      value.clearInput();
                    },
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _bodyEdit(AddNewServiceProvider value) {
    return Padding(
      padding: const EdgeInsets.all(Insets.i20),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                FormServiceImageLayout(),
                FormCategoryLayout(),
                FormPriceLayout(),
                SizedBox(height: 20),
              ],
            ),
          ),
          if (value.isEdit)
            Row(
              children: [
                if (value.isDraft == true) Expanded(child: _btnSave(value)),
                if (value.isDraft == true) const SizedBox(width: Insets.i10),
                if (value.serviceVersionSelected?.status !=
                    ServiceVersionStatus.active.name)
                  Expanded(child: _btnPublish(value)),
              ],
            ),
          if (!value.isEdit)
            ButtonCommon(
                title: value.isEdit ? appFonts.update : appFonts.addService,
                onTap: () {
                  value.addService(context);
                }),
        ],
      ),
    );
  }

  Widget _toolEdit(AddNewServiceProvider value) {
    return const SizedBox();
  }

  void _buildModalBottomSheet(AddNewServiceProvider value) {
    bool isDraftExist = value.serviceSelected?.versionsResponse
            ?.where((e) => e.publishedDate == null)
            .toList()
            .isNotEmpty ??
        false;

    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
            padding: const EdgeInsets.only(
                left: Insets.i20, right: Insets.i20, top: AppRadius.r10),
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
                    if (value.serviceVersionSelected?.publishedDate != null &&
                        value.serviceVersionSelected?.status ==
                            ServiceVersionStatus.active.name)
                      if (!isDraftExist)
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          color: appColor(context).appTheme.primary,
                          onPressed: () {
                            value.createCraft(callBack: () {
                              value.fetchCurrentService();
                              Navigator.of(context).pop();
                            });
                          },
                          tooltip: "Create new draft",
                        ),
                  ],
                ),
                const SizedBox(height: Insets.i10),
                Expanded(
                  child: ListView.builder(
                    itemCount: value.serviceVersionList?.length ?? 0,
                    itemBuilder: (context, index) {
                      final version = value.serviceVersionList![index];
                      final isSelected =
                          version.id == value.serviceVersionSelected?.id;

                      String statusText =
                          getPublishStatus(value, version: version);

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppRadius.r8),
                          color: isSelected
                              ? appColor(context)
                                  .appTheme
                                  .primary
                                  .withOpacity(0.1)
                              : null,
                        ),
                        child: ListTile(
                          selected: isSelected,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.r8),
                          ),
                          leading: BookingStatusLayout(
                            title: statusText,
                            color: colorCondition(
                                statusText.toLowerCase(), context),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                version.title ?? "",
                                style: appCss.dmDenseMedium14.textColor(
                                    appColor(context).appTheme.darkText),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${version.id}",
                                style: appCss.dmDenseRegular12.textColor(
                                    appColor(context).appTheme.lightText),
                              ),
                            ],
                          ),
                          trailing:
                              version.status == ServiceVersionStatus.active.name
                                  ? const Icon(Icons.check_circle,
                                      color: Colors.green)
                                  : null,
                          onTap: () {
                            value.onDraftSelected(version);
                            value.setIsDraft(version.publishedDate == null);
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            )));
  }

  Widget _btnSave(AddNewServiceProvider value) {
    if (value.isDraft == true) {
      return SizedBox(
        height: 50,
        width: double.infinity,
        child: ButtonCommon(
            color: Colors.red,
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
            title: "save",
            onTap: () {
              value.updateServiceCraft(callBack: () {
                Provider.of<ImageServiceProvider>(context, listen: false)
                    .removeAllImageServiceSelectedVersionMultiple();
                showDialog(
                    context: context,
                    builder: (context) => AppAlertDialogCommon(
                          image: eSvgAssets.service,
                          title: "Success",
                          subtext: "Service updated successfully",
                          singleText: "OK",
                          firstBText: "Cancel",
                          secondBText: "OK",
                          focusNode: FocusNode(),
                          firstBTap: () {
                            Navigator.of(context).pop();
                          },
                          secondBTap: () {
                            Navigator.of(context).pop();
                          },
                        ));
                value.fetchCurrentService();
              });
            }),
      );
    }
    return const SizedBox();
  }

  Widget _btnPublish(AddNewServiceProvider value) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ButtonCommon(
          color: Colors.green,
          icon: const Icon(
            Icons.publish,
            color: Colors.white,
          ),
          title: "Publish",
          onTap: () {
            value.publishService(callBack: () {
              value.fetchCurrentService();
              showDialog(
                  context: context,
                  builder: (context) => AppAlertDialogCommon(
                        image: eSvgAssets.service,
                        title: "Success",
                        subtext: "Service published successfully",
                        singleText: "OK",
                        firstBText: "Cancel",
                        secondBText: "OK",
                        focusNode: FocusNode(),
                        firstBTap: () {
                          Navigator.of(context).pop();
                        },
                        secondBTap: () {
                          Navigator.of(context).pop();
                        },
                      ));
              Provider.of<AllServiceProvider>(context, listen: false)
                  .getAllServices(limit: 5);
              // Navigator.of(context).popUntil((route) => route.isFirst);
            });
          }),
    );
  }
}
