import '../../../config.dart';

class BookingServicemenListScreen extends StatelessWidget {
  const BookingServicemenListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingServicemenListProvider>(
        builder: (context, value, child) {
      return StatefulWrapper(
        onInit: () => Future.delayed(
            const Duration(milliseconds: 20), () => value.onReady(context)),
        child: Scaffold(
            appBar: AppBarCommon(title: appFonts.servicemanList),
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SingleChildScrollView(
                    child: Column(children: [
                  SearchTextFieldCommon(
                      focusNode: value.searchFocus,
                      controller: value.searchCtrl,
                      suffixIcon: FilterIconCommon(
                          onTap: () => value.onTapFilter(context),
                          selectedFilter: "0")),
                  const VSpace(Sizes.s25),
                  ...appArray.availableServicemanList
                      .asMap()
                      .entries
                      .map((e) => BookingServicemenListLayout(
                          list: value.required,
                          selectedIndex: value.selectedIndex,
                          onTapRadio: () => value.onTapRadio(e.key),
                          data: e.value,
                          selList: value.selectCategory,
                          index: e.key,
                          onTap: () => value.onCategorySelected(e.key)))
                      .toList(),
                ]).padding(horizontal: Insets.i20,top: Insets.i20,bottom: Insets.i110)),
                Material(

                    child: ButtonCommon(
                            title: appFonts.assignBooking,
                            onTap: () => value.onAssignBooking(context)).paddingOnly(left:Insets.i20,right: Insets.i20))
              ],
            )),
      );
    });
  }
}
