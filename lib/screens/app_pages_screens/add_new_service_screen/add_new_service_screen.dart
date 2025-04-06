import 'package:salon_provider/model/response/service_version_response.dart';
import 'package:salon_provider/screens/app_pages_screens/add_new_service_screen/layouts/form_default_layout.dart';
import 'package:salon_provider/widgets/custom_drop_down_common.dart';
import 'package:salon_provider/widgets/dropdown_common.dart';

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
      bool? isCanSetDraft = value.itemServiceSelected?.versionsResponse
          ?.where((e) => e.publishedDate == null)
          .toList()
          .isEmpty;
      // if (value.showDraft ?? false) {
      //   isCanSetDraft = true;
      // }
      return StatefulWrapper(
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
              body: Column(children: [
                _dropdownDraftService(context, value),
                Divider(),
                Expanded(
                  child: Stack(children: [
                    const FieldsBackground(),
                    SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: Insets.i20),
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
              ]).paddingSymmetric(horizontal: Insets.i20)),
        ),
      );
    });
  }

  Widget _toolEdit(AddNewServiceProvider value) {
    return Row(
      children: [
        Expanded(child: _btnNewDraft(value)),
        const SizedBox(width: Insets.i10),
        Expanded(child: _btnSave(value)),
        const SizedBox(width: Insets.i10),
        Expanded(child: _btnPublish(value)),
      ],
    );
  }

  Widget _dropdownDraftService(
      BuildContext context, AddNewServiceProvider value) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(Insets.i10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ContainerWithTextLayout(title: "Draft Service")
          //     .paddingOnly(top: Insets.i24, bottom: Insets.i12),
          Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Insets.i15,
              ),
              child: CustomDropDownLayout<ServiceVersion>(
                // value: value.serviceVersionSelected,
                items: value.serviceVersionList ?? [],

                itemBuilder: (context, item) {
                  // return value.serviceVersionSelected?.id == item.id
                  //     ? Row(
                  //         children: [
                  //           Text("Published ${item.title}"),
                  //           const SizedBox(
                  //             width: 20,
                  //           ),
                  //           Icon(Icons.check_circle, color: Colors.green)
                  //         ],
                  //       )
                  //     : item.publishedDate == null
                  //         ? Text("Draft ${item.title} ")
                  //         : Text(item.title ?? '');
                  return item.publishedDate == null
                      ? Text("Draft ${item.title} ")
                      : Text(item.title ?? '');
                },
                // itemImage: (item) => item.,
                onChanged: (newValue) {
                  print(newValue);

                  Provider.of<AddNewServiceProvider>(context, listen: false)
                      .onCraftSelected(newValue!);
                  // Provider.of<AddNewServiceProvider>(context, listen: false)
                  //     .onShowDraft(
                  //         newValue!.publishedDate != null ? false : true);
                },
              )),
        ],
      ),
    );
  }

  Widget _btnNewDraft(AddNewServiceProvider value) {
    return ButtonCommon(
        color: Colors.red,
        title: "New draft",
        onTap: () {
          value.createCraft();
          // value.publishService(callBack: () {
          //   Navigator.of(context).pop();
          // });
        });
  }

  Widget _btnSave(AddNewServiceProvider value) {
    return ButtonCommon(
        color: Colors.red,
        title: "Save",
        onTap: () {
          // value.updateServiceCraft(callBack: () {
          //   Navigator.of(context).pop();
          // });
        });
  }

  Widget _btnPublish(AddNewServiceProvider value) {
    // if (value.serviceVersionSelected?.publishedDate != null) {}
    return ButtonCommon(
        color: Colors.green,
        title: "Publish",
        onTap: () {
          // value.publishService(callBack: () {
          //   Provider.of<AllServiceProvider>(context,
          //           listen: false)
          //       .getAllServices();
          //   Navigator.of(context).pop();
          // });
        });
  }
}
