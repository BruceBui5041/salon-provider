import '../../../config.dart';

class AddNewServiceScreen extends StatelessWidget {
  const AddNewServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewServiceProvider>(builder: (context1, value, child) {
      return StatefulWrapper(
        onInit: ()=> Future.delayed(const Duration(milliseconds: 20),()=>value.onReady(context)),
        child: PopScope(
          canPop: true,
          onPopInvoked: (bool? didPop)=> value.onBack(),
          child: Scaffold(
              appBar: AppBarCommon(title: value.isEdit ? appFonts.editService : appFonts.addNewService,onTap: ()=> value.onBackButton(context)),
              body: SingleChildScrollView(
                  child: Column(children: [
                Stack(children: [
                  const FieldsBackground(),
                  const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    FormServiceImageLayout(),
                    FormCategoryLayout(),
                    FormPriceLayout()
                  ]).paddingSymmetric(vertical: Insets.i20)
                ]),
                    ButtonCommon(title:  value.isEdit ? appFonts.update : appFonts.addService, onTap: ()=> route.pop(context)).paddingOnly(top: Insets.i40,bottom: Insets.i30)
              ]).paddingSymmetric(horizontal: Insets.i20))),
        ),
      );
    });
  }
}
