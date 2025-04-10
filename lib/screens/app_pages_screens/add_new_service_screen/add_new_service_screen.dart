import 'package:salon_provider/common/enum_value.dart';
import 'package:salon_provider/model/response/service_version_response.dart';
import 'package:salon_provider/providers/app_pages_provider/all_service_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewServiceProvider>(builder: (context1, value, child) {
      print("subCategoryValue: ${value.subCategoryValue}");
      return StatefulWrapper(
          onDispose: () {
            Provider.of<AddNewServiceProvider>(context, listen: false)
                .clearInput();
          },
          onInit: () => Future.delayed(
              const Duration(milliseconds: 20), () => value.onReady(context)),
          child: PopScope(
            canPop: true,
            onPopInvoked: (bool? didPop) => value.onBack(),
            child: Scaffold(
              appBar: AppBarCommon(
                  title: value.isEdit
                      ? appFonts.editService
                      : appFonts.addNewService,
                  onTap: () => value.onBackButton(context)),
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
    return Column(children: [
      // _dropdownDraftService(context, value),
      Expanded(
        child: Stack(children: [
          const FieldsBackground(),
          SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (value.isEdit) _toolEdit(value),
              FormServiceImageLayout(),
              FormCategoryLayout(),
              FormPriceLayout(),
              // FormServiceDefaultLayout(),
            ]).paddingSymmetric(vertical: Insets.i20),
          )
        ]),
      ),

      ButtonCommon(
          title: value.isEdit ? appFonts.update : appFonts.addService,
          onTap: () {
            value.addService();
          }).paddingOnly(top: Insets.i10, bottom: Insets.i5),

      const SizedBox(
        height: 20,
      ),
    ]).paddingSymmetric(horizontal: Insets.i20);
  }

  Widget _bodyEdit(AddNewServiceProvider value) {
    return Column(children: [
      // _dropdownDraftService(context, value),

      Expanded(
        child: Stack(children: [
          const FieldsBackground(),
          SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // if (value.isEdit) _toolEdit(value),
              FormServiceImageLayout(),
              FormCategoryLayout(),
              FormPriceLayout(),
              // FormServiceDefaultLayout(),
            ]).paddingSymmetric(vertical: Insets.i20),
          )
        ]),
      ),
      const SizedBox(height: Insets.i10),
      Stack(
        children: [
          const FieldsBackground(),
          Column(
            children: [
              if (value.isEdit)
                Padding(
                  padding: const EdgeInsets.only(
                      top: Insets.i10, left: Insets.i20, right: Insets.i20),
                  child: _dropdownDraftServiceCustom(value),
                ),
              const SizedBox(height: Insets.i10),
              if (value.isEdit)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Insets.i20,
                  ),
                  child: Row(
                    children: [
                      if (value.isDraft == true)
                        Expanded(child: _btnSave(value)),
                      if (value.isDraft == true)
                        const SizedBox(width: Insets.i10),
                      if (value.serviceVersionSelected?.status !=
                          ServiceVersionStatus.active.name)
                        Expanded(child: _btnPublish(value)),
                    ],
                  ),
                ),
              if (!value.isEdit)
                ButtonCommon(
                    title: value.isEdit ? appFonts.update : appFonts.addService,
                    onTap: () {
                      value.addService();
                    }).paddingOnly(top: Insets.i10, bottom: Insets.i5),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      )
    ]).paddingSymmetric(horizontal: Insets.i20);
  }

  Widget _toolEdit(AddNewServiceProvider value) {
    return _btnNewDraft(value);
  }

  Widget _dropdownDraftServiceCustom(AddNewServiceProvider value) {
    if (value.serviceVersionList!.isEmpty) {
      return const SizedBox();
    }
    var initServiceVersion = value.serviceVersionList
        ?.firstWhere((e) => e.id == value.serviceVersionSelected?.id);
    bool isDraftExist = value.serviceSelected?.versionsResponse
            ?.where((e) => e.publishedDate == null)
            .toList()
            .isNotEmpty ??
        false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select version",
          style: appCss.dmDenseMedium14
              .textColor(appColor(context).appTheme.darkText),
        ),
        const SizedBox(height: Insets.i10),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<ServiceVersion>(
                value: initServiceVersion ?? null,
                decoration: InputDecoration(
                  disabledBorder: const OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppRadius.r8)),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppRadius.r8)),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppRadius.r8)),
                    borderSide: BorderSide.none,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppRadius.r8)),
                    borderSide: BorderSide.none,
                    // borderSide: BorderSide.none,
                  ),
                ),
                hint: const Text('Select a draft service'),
                isExpanded: true,
                style: appCss.dmDenseMedium14
                    .textColor(appColor(context).appTheme.lightText),
                items: value.serviceVersionList?.map((ServiceVersion service) {
                      String draftText = "";

                      if (service.publishedDate == null) {
                        draftText = "(Draft)";
                      } else {
                        draftText = "";
                      }
                      return DropdownMenuItem<ServiceVersion>(
                        key: ValueKey(service.id),
                        value: service,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "$draftText ${service.title} (${service.id})",
                                style: appCss.dmDenseMedium14.textColor(
                                    appColor(context).appTheme.darkText),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: true,
                                textAlign: TextAlign.start,
                                textWidthBasis: TextWidthBasis.parent,
                                textHeightBehavior: TextHeightBehavior(
                                  leadingDistribution:
                                      TextLeadingDistribution.proportional,
                                ),
                              ),
                            ),
                            const SizedBox(width: Insets.i10),
                            if (service.status ==
                                ServiceVersionStatus.active.name)
                              Icon(Icons.check_circle, color: Colors.green),
                          ],
                        ),
                      );
                    }).toList() ??
                    [],
                onChanged: (ServiceVersion? newValue) {
                  if (newValue != null) {
                    value.onDraftSelected(newValue);
                    value.setIsDraft(newValue.publishedDate == null);
                  }
                },
              ).decorated(
                color: appColor(context).appTheme.whiteBg,
                borderRadius: BorderRadius.circular(AppRadius.r8),
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     value.fetchCurrentService();
            //   },
            //   child: Icon(Icons.refresh,
            //       color: appColor(context).appTheme.lightText),
            // ),
          ],
        ),
        // const SizedBox(width: Insets.i4),
        if (value.serviceVersionSelected?.publishedDate != null &&
            value.serviceVersionSelected?.status ==
                ServiceVersionStatus.active.name)
          if (!isDraftExist) _btnNewDraft(value),
      ],
    );
  }

  Widget _btnNewDraft(AddNewServiceProvider value) {
    return Padding(
      padding: const EdgeInsets.only(top: Insets.i6),
      child: ButtonCommon(
          // color: Colors.red,

          icon: Icon(
            Icons.edit_document,
            color: Colors.white,
          ),
          title: null,
          onTap: () {
            value.createCraft(callBack: () {
              value.fetchCurrentService();
            });
            // value.publishService(callBack: () {
            //   Navigator.of(context).pop();
            // });
          }),
    );
  }

  Widget _btnSave(AddNewServiceProvider value) {
    if (value.isDraft == true) {
      return SizedBox(
        height: 50,
        width: double.infinity,
        child: ButtonCommon(
            color: Colors.red,
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            title: "save",
            onTap: () {
              value.updateServiceCraft(callBack: () {
                value.fetchCurrentService();
              });
            }),
      );
    }
    return const SizedBox();
  }

  Widget _btnPublish(AddNewServiceProvider value) {
    // if (value.serviceVersionSelected?.status == "active") {
    //   return const SizedBox();
    // }
    // if (value.serviceVersionSelected?.publishedDate != null) {}
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ButtonCommon(
          color: Colors.green,
          icon: Icon(
            Icons.publish,
            color: Colors.white,
          ),
          title: "Publish",
          onTap: () {
            value.publishService(callBack: () {
              value.fetchCurrentService();

              Provider.of<AllServiceProvider>(context, listen: false)
                  .getAllServices();
              // Navigator.of(context).popUntil((route) => route.isFirst);
            });
          }),
    );
  }
}
