import '../../../config.dart';

class CommissionInfoScreen extends StatelessWidget {
  const CommissionInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CommissionInfoProvider>(
      builder: (context,value,child) {
        return StatefulWrapper(
          onInit: ()=> Future.delayed(const Duration(milliseconds: 50),()=> value.onReady()),
          child: Scaffold(
            appBar: AppBarCommon(title: appFonts.commissionInfo),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SearchTextFieldCommon(focusNode: value.searchFocus,controller: value.searchCtrl),
                  const VSpace(Sizes.s20),
                  ...value.commissionList.asMap().entries.map((e) => CategoriesListLayout(data: e.value,isCommission: true,onTap: ()=> route.pushNamed(context, routeName.commissionDetail)))
              
                ]
              ).paddingSymmetric(horizontal: Insets.i20),
            )
          )
        );
      }
    );
  }
}
