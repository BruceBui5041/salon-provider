import '../../../config.dart';

class IdVerificationScreen extends StatelessWidget {
  const IdVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IdVerificationProvider>(
      builder: (context,value,child) {
        return Scaffold(
            appBar: AppBarCommon(title: appFonts.idVerification),
            body: SingleChildScrollView(
                child:
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(language(context, appFonts.submittedDocument),
                  style: appCss.dmDenseMedium14
                      .textColor(appColor(context).appTheme.lightText)),
              const VSpace(Sizes.s15),
              ...appArray.documentsList
                  .asMap()
                  .entries
                  .map((e) => DocumentLayout(
                        data: e.value,
                        list: appArray.documentsList,
                        index: e.key,
                      ))
                  .toList(),
              const VSpace(Sizes.s25),
              Text(language(context, appFonts.pendingDocument),
                  style: appCss.dmDenseMedium14
                      .textColor(appColor(context).appTheme.lightText)),
              const VSpace(Sizes.s15),
              ...appArray.pendingDocumentList
                  .asMap()
                  .entries
                  .map((e) => PendingDocumentLayout(onTap: ()=> value.onImagePick(context),data: e.value))
                  .toList()
            ]).paddingSymmetric(horizontal: Insets.i20)));
      }
    );
  }
}
