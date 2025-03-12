import 'package:fixit_provider/screens/app_pages_screens/add_new_service_screen/layouts/form_default_layout.dart';

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
    Provider.of<AddNewServiceProvider>(context, listen: false).clearInput();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewServiceProvider>(builder: (context1, value, child) {
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
              body: SingleChildScrollView(
                  child: Column(children: [
                Stack(children: [
                  const FieldsBackground(),
                  const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // FormServiceImageLayout(),
                        // FormCategoryLayout(),
                        // FormPriceLayout()
                        FormServiceDefaultLayout(),
                      ]).paddingSymmetric(vertical: Insets.i20)
                ]),
                ButtonCommon(
                    title: value.isEdit ? appFonts.update : appFonts.addService,
                    onTap: () {
                      value.addService();
                    }).paddingOnly(top: Insets.i40, bottom: Insets.i30)
              ]).paddingSymmetric(horizontal: Insets.i20))),
        ),
      );
    });
  }
}
