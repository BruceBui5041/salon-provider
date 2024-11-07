import 'dart:developer';

import 'package:fixit_provider/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../widgets/year_dialog.dart';

class AddPackageProvider with ChangeNotifier {

   TextEditingController packageCtrl = TextEditingController();
   TextEditingController descriptionCtrl = TextEditingController();
   TextEditingController amountCtrl = TextEditingController();
   TextEditingController disclaimerCtrl = TextEditingController();
   TextEditingController startDateCtrl = TextEditingController();
   TextEditingController endDateCtrl = TextEditingController();
   TextEditingController emptyCtrl = TextEditingController();

   FocusNode packageFocus = FocusNode();
   FocusNode descriptionFocus = FocusNode();
   FocusNode amountFocus = FocusNode();
   FocusNode disclaimerFocus = FocusNode();
   FocusNode startDateFocus = FocusNode();
   FocusNode endDateFocus = FocusNode();

    bool isSwitch = true,isEdit = false;

   DateTime? slotSelectedDay;
   DateTime slotSelectedYear = DateTime.now();
   dynamic chosenValue;
   DateTime? selectedDay;
   DateTime selectedYear = DateTime.now();
   final ValueNotifier<DateTime> focusedDay = ValueNotifier(DateTime.now());
   CalendarFormat calendarFormat = CalendarFormat.month;
   int demoInt = 0;
   PageController pageController = PageController();
   TextEditingController categoryCtrl = TextEditingController();
   RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOn; // Can be toggled on/off by longpressing a date
   DateTime? rangeStart;
   DateTime? rangeEnd;
   DateTime currentDate = DateTime.now();
   String? month,image;
   String showYear = 'Select Year';



   onBack(context){
     final value = Provider.of<SelectServiceProvider>(context,listen: false);
     isEdit = false;
     packageCtrl.text = "";
     amountCtrl.text = "";
     startDateCtrl.text = "";
     endDateCtrl.text = "";
     descriptionCtrl.text = '';
     disclaimerCtrl.text = '';
     value.selectServiceList =  [];
     notifyListeners();
   }

   onBackButton(context){
     final value = Provider.of<SelectServiceProvider>(context,listen: false);
     isEdit = false;
     packageCtrl.text = "";
     amountCtrl.text = "";
     startDateCtrl.text = "";
     endDateCtrl.text = "";
     descriptionCtrl.text = '';
     disclaimerCtrl.text = '';
     value.selectServiceList = [];
     notifyListeners();
     route.pop(context);
   }

   onPackageDelete(context,sync){
     final value = Provider.of<DeleteDialogProvider>(context, listen: false);

     value.onDeleteDialog(sync, context, eImageAssets.packageDelete, appFonts.deletePackages, appFonts.areYouSureDeletePackage,  (){
       route.pop(context);
       value.onResetPass(context, language(context, appFonts.hurrayPackageDelete), language(context, appFonts.okay), () {
         Navigator.pop(context);
         Navigator.pop(context);
       });

     });
     value.notifyListeners();


   }

   onInit(context) {

     dynamic data = ModalRoute.of(context)!.settings.arguments ?? "";
     final value = Provider.of<SelectServiceProvider>(context,listen: false);
     log("ARGSS DATATA $data");


     if(data["isEdit"] != "") {
       isEdit = data["isEdit"] ?? false;

     }
     if (data["data"] != null) {
       log("ARGSFDCGD");
       packageCtrl.text = data["data"]["title"] ?? '';
       amountCtrl.text = data["data"]["price"]?? '';
       startDateCtrl.text = data["data"]["startDate"]?? '';
       endDateCtrl.text = data["data"]["expiryDate"]?? '';
       descriptionCtrl.text = data["data"]["description"]?? '';
       disclaimerCtrl.text = data["data"]["disclaimer"]?? '';
       value.selectServiceList = data["data"]["image_list"]?? [];
     }

     focusedDay.value = DateTime.utc(focusedDay.value.year,
         focusedDay.value.month, focusedDay.value.day + 0);
     onDaySelected(focusedDay.value, focusedDay.value);
     DateTime dateTime = DateTime.now();
     int index = appArray.monthList
         .indexWhere((element) => element['index'] == dateTime.month);
     chosenValue = appArray.monthList[index];
     descriptionFocus.addListener(() {
       notifyListeners();
     });
     disclaimerFocus.addListener(() {
       notifyListeners();
     });
     notifyListeners();
   }

    onSwitch(val){
       isSwitch = val;
       notifyListeners();
    }

   onTapMonth(val){
      month = val;
      notifyListeners();
   }

   onRangeSelect(start, end, focusedDay) {
      selectedDay = null;
      currentDate = focusedDay;
      rangeStart = start;
      rangeEnd = end;
      rangeSelectionMode = RangeSelectionMode.toggledOn;
      startDateCtrl.text = rangeStart.toString();
      endDateCtrl.text = rangeEnd != null ? rangeEnd.toString() : "";
      notifyListeners();
   }

   selectYear(context) async {
      showDialog(
          context: context,
          builder: (BuildContext context3) {
             return  YearAlertDialog(
               selectedDate: selectedYear,
               onChanged: (DateTime dateTime) {
                  selectedYear = dateTime;
                  showYear = "${dateTime.year}";
                  focusedDay.value = DateTime.utc(
                      selectedYear.year,
                      chosenValue["index"],
                      focusedDay.value.day + 0);
                  onDaySelected(
                      focusedDay.value,
                      focusedDay.value);
                  notifyListeners();
                 route.pop(context);
                 log("YEAR CHANGE : ${ focusedDay.value}");
               }
             );
          });
   }

   onRightArrow() {
     pageController.nextPage(
         duration: const Duration(microseconds: 200), curve: Curves.bounceIn);
     final newMonth = focusedDay.value.add(const Duration(days: 30));
     focusedDay.value = newMonth;
     int index = appArray.monthList
         .indexWhere((element) => element['index'] == focusedDay.value.month);
     chosenValue = appArray.monthList[index];
     selectedYear = DateTime.utc(focusedDay.value.year, focusedDay.value.month,
         focusedDay.value.day + 0);
     notifyListeners();
   }

   onLeftArrow() {
     if( focusedDay.value.month != DateTime.january || focusedDay.value.year != DateTime.now().year) {
       pageController.previousPage(
           duration: const Duration(microseconds: 200), curve: Curves.bounceIn);
       final newMonth = focusedDay.value.subtract(const Duration(days: 30));
       focusedDay.value = newMonth;
       int index = appArray.monthList
           .indexWhere((element) => element['index'] == focusedDay.value.month);
       chosenValue = appArray.monthList[index];
       selectedYear = DateTime.utc(focusedDay.value.year, focusedDay.value.month,
           focusedDay.value.day + 0);
     }
     notifyListeners();
   }

   void onDaySelected(DateTime selectDay, DateTime fDay) {
      notifyListeners();
      focusedDay.value = selectDay;
   }

   onPageCtrl(dayFocused) {
      focusedDay.value = dayFocused;
      demoInt = dayFocused.year;
      notifyListeners();
   }



   onCalendarCreate(controller) {
      pageController = controller;
   }

   onDropDownChange(choseVal) {
      notifyListeners();
      chosenValue = choseVal;

      notifyListeners();
      int index = choseVal['index'];
      focusedDay.value =
          DateTime.utc(focusedDay.value.year, index, focusedDay.value.day + 0);
      onDaySelected(focusedDay.value, focusedDay.value);

   }

   onSelect(context){
    route.pop(context);
      /*if(rangeEnd != null){
        route.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("opps!! you have not select date yet.",style: appCss.dmDenseMedium12.textColor(appColor(context).appTheme.whiteColor)),backgroundColor: appColor(context).appTheme.red));
      }*/
      notifyListeners();
   }
    
    onDateSelect(context){
       showModalBottomSheet(
           isScrollControlled: true,
           context: context, builder: (context) => StatefulBuilder(
             builder: (context, setState) {
               return Consumer<AddPackageProvider>(
                 builder: (context,value,child) {
                   return SizedBox(
                             height: MediaQuery.of(context).size.height * 0.57,
                            child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                         Text(language(context, appFonts.selectDate),
                             style: appCss.dmDenseMedium18
                                 .textColor(appColor(context).appTheme.darkText)),
                         const Icon(CupertinoIcons.multiply)
                             .inkWell(onTap: () => route.pop(context))
                       ]).paddingSymmetric(horizontal: Insets.i20,vertical: Insets.i15),

                        Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               CommonArrow(arrow: eSvgAssets.arrowLeft,
                                   onTap: () =>  onLeftArrow()),
                               const HSpace(Sizes.s20),
                               Container(
                                   height: Sizes.s34,
                                   alignment: Alignment.center,
                                   width: Sizes.s100,
                                   child: DropdownButton(
                                       underline: Container(),
                                       focusColor: Colors.white,
                                       value:  chosenValue,
                                       style: const TextStyle(color: Colors.white),
                                       iconEnabledColor: appColor(context).appTheme
                                           .darkText,
                                       items: appArray.monthList
                                           .map<DropdownMenuItem>((monthValue) {
                                          return DropdownMenuItem(
                                              onTap: () =>
                                                   onTapMonth(
                                                      monthValue['title']),
                                              value: monthValue,
                                              child: Text(monthValue['title'],
                                                  style:
                                                  TextStyle(color: appColor(context)
                                                      .appTheme.darkText)));
                                       }).toList(),
                                       icon: SvgPicture.asset(eSvgAssets.dropDown),
                                       onChanged: (choseVal) =>
                                            onDropDownChange(choseVal)))
                                   .boxShapeExtension(
                                   color: appColor(context).appTheme.fieldCardBg,
                                   radius: AppRadius.r4),
                               const HSpace(Sizes.s20),
                               Container(
                                   alignment: Alignment.center,
                                   height: Sizes.s34,
                                   width: Sizes.s87,
                                   child: Row(
                                       mainAxisAlignment: MainAxisAlignment
                                           .spaceAround,
                                       children: [
                                          Text("${ selectedYear.year}"),
                                          SvgPicture.asset(eSvgAssets.dropDown)
                                       ])).boxShapeExtension(
                                   color: appColor(context).appTheme.fieldCardBg,
                                   radius: AppRadius.r4)
                                   .inkWell(
                                   onTap: () =>  selectYear(context)),
                               const HSpace(Sizes.s20),
                               CommonArrow(arrow: eSvgAssets.arrowRight,
                                   onTap: () =>  onRightArrow()),
                            ]).paddingSymmetric(horizontal: Insets.i10),
                        const VSpace(Sizes.s15),
                       TableCalendar(
                           rowHeight: 40,
                           headerVisible: false,
                           daysOfWeekVisible: true,
                           pageJumpingEnabled: true,
                           pageAnimationEnabled: false,
                           rangeSelectionMode: RangeSelectionMode.toggledOn,
                           lastDay: DateTime.utc(DateTime.now().year + 100, 3, 14),
                           firstDay: DateTime.utc(DateTime.now().year, DateTime.january, DateTime.now().day),
                           onDaySelected: value.onDaySelected,
                           focusedDay: value.focusedDay.value,
                           rangeStartDay: value.rangeStart,
                           rangeEndDay: value.rangeEnd,
                           availableGestures: AvailableGestures.none,
                           calendarFormat: value.calendarFormat,
                           startingDayOfWeek: StartingDayOfWeek.monday,
                           onRangeSelected: (start, end, focusedDay) =>
                               value.onRangeSelect(start, end, focusedDay),
                           headerStyle:  const HeaderStyle(
                               leftChevronVisible: false,
                               formatButtonVisible: false,
                               rightChevronVisible: false),
                           onPageChanged: (dayFocused) =>
                               value.onPageCtrl(dayFocused),
                           onCalendarCreated: (controller) =>
                               value.onCalendarCreate(controller),
                           selectedDayPredicate: (day) {
                             return isSameDay(value.focusedDay.value, day);
                           },
                           daysOfWeekStyle: DaysOfWeekStyle(

                               dowTextFormatter: (date, locale) =>
                               DateFormat.E(locale).format(date)[0],
                               weekdayStyle: appCss.dmDenseBold14.textColor(appColor(context).appTheme.primary),

                               weekendStyle: appCss.dmDenseBold14.textColor(appColor(context).appTheme.primary)),
                           calendarStyle: CalendarStyle(rangeHighlightColor: appColor(context).appTheme.primary.withOpacity(0.10),
                               rangeEndDecoration: BoxDecoration(
                                   color: appColor(context).appTheme.primary,
                                   shape: BoxShape.circle
                               ),
                               defaultTextStyle: appCss.dmDenseLight14.textColor(appColor(context).appTheme.darkText),
                               withinRangeTextStyle: appCss.dmDenseLight14.textColor(appColor(context).appTheme.primary),
                               rangeStartTextStyle: appCss.dmDenseLight14.textColor(appColor(context).appTheme.whiteColor),
                               rangeEndTextStyle: appCss.dmDenseLight14.textColor(appColor(context).appTheme.whiteColor),
                               rangeStartDecoration:BoxDecoration(
                                   color: appColor(context).appTheme.primary,
                                   shape: BoxShape.circle
                               ),
                               todayTextStyle: appCss.dmDenseMedium14
                                   .textColor(appColor(context).appTheme.primary),
                               todayDecoration: BoxDecoration(
                                   color: appColor(context)
                                       .appTheme
                                       .primary
                                       .withOpacity(.10),
                                   shape: BoxShape.circle))).paddingAll(
                           Insets.i20)
                           .boxShapeExtension(
                           color: appColor(context).appTheme.fieldCardBg)
                           .paddingSymmetric(horizontal: Insets.i20),
                       const VSpace(Sizes.s15),
                       ButtonCommon(title: appFonts.selectDate,onTap: ()=> onSelect(context)).paddingSymmetric(horizontal: Insets.i20)
                     ]
                            ),
                          );
                 }
               );
             }
           ));
    }

}