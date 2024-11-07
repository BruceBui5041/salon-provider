import '../../../config.dart';

class AddServiceProofScreen extends StatelessWidget {
  const AddServiceProofScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddServiceProofProvider>(builder: (context, value, child) {
      return StatefulWrapper(
        onInit: ()=> Future.delayed(const Duration(milliseconds: 20),()=> value.onReady()),
        child: Scaffold(
            appBar: AppBarCommon(title: appFonts.addServiceProof),
            body: SingleChildScrollView(
              child: Column(children: [
                Stack(clipBehavior: Clip.none, children: [
                  const FieldsBackground(),
                  Form(
                    key: value.formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ContainerWithTextLayout(
                              title: language(context, appFonts.title)),
                          const VSpace(Sizes.s8),
                          TextFieldCommon(
                                  focusNode: value.titleFocus,
                                  hintText: language(context, appFonts.enterTitle),
                                  controller: value.titleCtrl,
                                  prefixIcon: eSvgAssets.buildings)
                              .paddingSymmetric(horizontal: Insets.i20),
                          const VSpace(Sizes.s15),
                          ContainerWithTextLayout(
                              title: language(context, appFonts.description)),
                          const VSpace(Sizes.s8),
                          Stack(children: [
                            TextFieldCommon(
                                    focusNode: value.descriptionFocus,
                                    isNumber: true,
                                    controller: value.descriptionCtrl,
                                    hintText: appFonts.enterDetails,
                                    maxLines: 3,
                                    minLines: 3,
                                    isMaxLine: true)
                                .paddingSymmetric(horizontal: Insets.i20),
                            SvgPicture.asset(eSvgAssets.details,
                                    fit: BoxFit.scaleDown,
                                    colorFilter: ColorFilter.mode(
                                        !value.descriptionFocus.hasFocus
                                            ? value.descriptionCtrl.text.isNotEmpty
                                            ? appColor(context).appTheme.darkText
                                            : appColor(context).appTheme.lightText
                                            : appColor(context).appTheme.darkText,
                                        BlendMode.srcIn))
                                .paddingOnly(
                                    left: rtl(context) ? 0 : Insets.i35,
                                    right: rtl(context) ? Insets.i35 : 0,
                                    top: Insets.i13)
                          ]),
                          const VSpace(Sizes.s15),
                          ContainerWithTextLayout(
                              title: language(context, appFonts.serviceImage)),
                          const VSpace(Sizes.s8),
        
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: [
                                    value.proofList.isNotEmpty ?
                                    Row(
                                      children:  value.proofList
                                  .asMap()
                                  .entries
                                  .map((e) => AddServiceImageLayout(
                                  onDelete: ()=> value.onImageRemove(e.key),
                                  image: e.value))
                                  .toList())
                              .paddingOnly(
                              left: rtl(context) ? 0 : Insets.i20,
                              right: rtl(context) ? Insets.i20 : 0) : Container(),
                                    AddNewBoxLayout(title: appFonts.addNew,onAdd: ()=> value.onImagePick(context)).paddingSymmetric(horizontal: value.proofList.isNotEmpty ? 0 : Insets.i20)
                                  ])),
        
                          const VSpace(Sizes.s40),
                          ButtonCommon(title: appFonts.submit,onTap: ()=> value.onSubmit(context))
                              .paddingSymmetric(horizontal: Insets.i20)
                        ]).paddingSymmetric(vertical: Insets.i20),
                  )
                ])
              ]).paddingSymmetric(horizontal: Insets.i20)
            )),
      );
    });
  }
}