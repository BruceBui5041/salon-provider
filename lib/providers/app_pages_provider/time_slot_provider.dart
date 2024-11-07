import 'dart:developer';

import 'package:fixit_provider/config.dart';


class TimeSlotProvider with ChangeNotifier {

  TextEditingController hourGap = TextEditingController();
  FocusNode hourGapFocus = FocusNode();

  CarouselController hourCtrl = CarouselController();
  CarouselController minCtrl = CarouselController();
  CarouselController amPmCtrl = CarouselController();
  int scrollDayIndex = 0;
  int scrollMinIndex = 0;
  int scrollHourIndex = 0;
  int indexs = 0;
  FixedExtentScrollController? controller;


  String? gapValue;

    onToggle(data,val) {
      data["status"] = val;
      notifyListeners();
    }

    onMonthChange(val) {
      gapValue = val;
      notifyListeners();
    }


  onHourScroll(index) {
    scrollHourIndex = index;
    notifyListeners();
  }

  onMinScroll(index) {
    scrollMinIndex = index;
    notifyListeners();
  }

  onDayScroll(index) {
    scrollDayIndex = index;
    notifyListeners();
  }

  selectTimeBottomSheet(context,val,index,type) {
    scrollHourIndex = 0;
    scrollMinIndex = 0;
    notifyListeners();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context2) {
        return SelectTimeSheet(onTap: ()=> onAddTime(val,index,context,type));
      },
    );
  }



  onAddTime(val,index,context,type){
      int hr = scrollHourIndex + 1;
      int mn = scrollMinIndex + 1;

    log("VALALA $val");
    log("INSDE $index");

    if(type == "start") {
      appArray.timeSlotList[index]["start_at"] =
      "${hr.toString()} : ${mn.toString()}";
    }else{
      appArray.timeSlotList[index]["end_at"] =
      "${hr.toString()} : ${mn.toString()}";
    }
    notifyListeners();
    route.pop(context);
  }

  onHourChange(index){
    scrollHourIndex = index;
    notifyListeners();
  }

  onMinChange(index){
    scrollMinIndex = index;
    notifyListeners();
  }

  onAmPmChange(index){
    scrollDayIndex = index;
    notifyListeners();
  }

  onUpdateHour(context){
    showDialog(context: context, builder: (context) => AlertDialogCommon(
        title: appFonts.updateSuccessfully,
        height: Sizes.s140,
        image: eGifAssets.successGif,
        subtext: language(context, appFonts.hurrayUpdateHour),
        bText1: language(context, appFonts.okay),
        b1OnTap: ()=> route.pop(context)
    ));
  }

}