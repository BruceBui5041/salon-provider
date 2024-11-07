import '../config.dart';

Color colorCondition(String? text,context){
  if(text == appFonts.pending){
    return appColor(context).appTheme.pending;
  } else if (text == appFonts.accepted){
    return appColor(context).appTheme.accepted;
  } else if (text == appFonts.ongoing){
    return appColor(context).appTheme.ongoing;
  } else if (text == appFonts.cancelled){
    return appColor(context).appTheme.red;
  }  else if (text == appFonts.pendingApproval){
    return appColor(context).appTheme.pendingApproval;
  } else if (text == appFonts.hold){
    return appColor(context).appTheme.hold;
  } else if (text == appFonts.assigned){
    return appColor(context).appTheme.assign;
  } else {
    return  appColor(context).appTheme.primary;
  }
}

  starCondition(String? rate){
    if(rate == "0"){
        return eSvgAssets.star;
    } else if(rate == "0.5"){
        return eSvgAssets.star;
    } else if(rate == "1"){
        return eSvgAssets.star1;
    }else if(rate == "1.5"){
        return eSvgAssets.star1;
    } else if(rate == "2"){
        return eSvgAssets.star2;
    } else if(rate == "3"){
        return eSvgAssets.star3;
    } else if(rate == "4"){
        return eSvgAssets.star4;
    } else if(rate == "5"){
        return eSvgAssets.star5;
    } else {
      return eSvgAssets.star3;
    }
  }

String monthCondition(String? text) {


  if(text == '1'){
    return "JAN";
  } else if (text == '2') {
    return "FEB";
  }else if (text == '3') {
    return "MAR";
  }else if (text == '4') {
    return "APR";
  }else if (text == '5') {
    return "MAY";
  }else if (text == '6') {
    return "JUN";
  }else if (text == '7') {
    return "JUL";
  }else if (text == '8') {
    return "AUG";
  }else if (text == '9') {
    return "SEP";
  }else if (text == '10') {
    return "OCT";
  }else if (text == "11") {
    return "NOV";
  }else if (text == '12') {
    return "DEC";
  } else {
    return "JAN";
  }

}