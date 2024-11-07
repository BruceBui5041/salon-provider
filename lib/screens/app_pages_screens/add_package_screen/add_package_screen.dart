import '../../../config.dart';

class AddPackageScreen extends StatefulWidget {
  const AddPackageScreen({super.key});

  @override
  State<AddPackageScreen> createState() => _AddPackageScreenState();
}

class _AddPackageScreenState extends State<AddPackageScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AddPackageProvider,SelectServiceProvider>(builder: (context, value,selectVal, child) {
      return StatefulWrapper(
        onInit: ()=> Future.delayed(const Duration(milliseconds: 20),()=> value.onInit(context)),
        child: PopScope(
          canPop: true,
          onPopInvoked: (bool didPop)=> value.onBack(context),
          child: Scaffold(
              appBar: ActionAppBar(title: value.isEdit ?  appFonts.editPackage : appFonts.addPackage,onTap: ()=> value.onBackButton(context), actions: [
                if(value.isEdit)
                CommonArrow(arrow: eSvgAssets.delete,onTap: ()=> value.onPackageDelete(context,this))
                    .paddingSymmetric(horizontal: Insets.i20)
              ]),
              body: SingleChildScrollView(
                  child: Column(
                      children: [
                Stack(children: [
                  const FieldsBackground(),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    ContainerWithTextLayout(
                        title: language(context, appFonts.packageName)),
                    const VSpace(Sizes.s8),
                    TextFieldCommon(
                      focusNode: value.packageFocus,
                            controller: value.packageCtrl,
                            hintText: language(context, appFonts.enterPackageName),
                            prefixIcon: eSvgAssets.packageName)
                        .padding(horizontal: Insets.i20, bottom: Insets.i15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            const SmallContainer(),
                            const HSpace(Sizes.s20),
                            Text(language(context, appFonts.selectServiceOnly),
                                //overflow: TextOverflow.ellipsis,
                                style: appCss.dmDenseSemiBold14
                                    .textColor(appColor(context).appTheme.darkText)).width(Sizes.s120)
                          ]),
                          if(selectVal.selectServiceList.isNotEmpty)
                          Text(language(context, appFonts.editService),
                                  textAlign: rtl(context) ? TextAlign.end : TextAlign.start ,
                                  overflow: TextOverflow.ellipsis,
                                  style: appCss.dmDenseMedium12.textColor(
                                      appColor(context).appTheme.primary)).inkWell(onTap: ()=> route.pushNamed(context, routeName.selectService))
                              .paddingSymmetric(horizontal: Insets.i20)
                        ]),
                    const VSpace(Sizes.s15),
                    selectVal.selectServiceList.isNotEmpty ?
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                                children: selectVal.selectServiceList
                                    .asMap()
                                    .entries
                                    .map((e) => SelectServiceLayout(
                                    onTapCross: ()=> selectVal.onImageRemove(e.value["id"],e.key,e.value),
                                    data: e.value))
                                    .toList())
                            .paddingOnly(
                                left: rtl(context) ? 0 : Insets.i20,
                                right: rtl(context) ? Insets.i20 : 0)) : AddNewBoxLayout(title: appFonts.addNew,onAdd: ()=> route.pushNamed(context, routeName.selectService)).paddingSymmetric(horizontal: Insets.i20),
                    const VSpace(Sizes.s20),
                    const PackageDescriptionForm()
                  ]).paddingSymmetric(vertical: Insets.i20)
                ]),
                    ButtonCommon(title: value.isEdit ? appFonts.updatePackage : appFonts.addPackage,onTap: ()=> route.pop(context)).paddingOnly(top: Insets.i40,bottom: Insets.i30)
              ]).paddingSymmetric(horizontal: Insets.i20))),
        ),
      );
    });
  }
}
