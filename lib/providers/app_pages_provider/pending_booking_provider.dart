import 'package:fixit_provider/model/pending_booking_model.dart';
import '../../config.dart';

class PendingBookingProvider with ChangeNotifier {
  PendingBookingModel? pendingBookingModel;

  TextEditingController reasonCtrl = TextEditingController();
  TextEditingController amountCtrl = TextEditingController();
  FocusNode reasonFocus = FocusNode();
  FocusNode amountFocus = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> amountFormKey = GlobalKey<FormState>();

  bool isServicemen = false,isAmount = false;


  onReady(context){
   if(isFreelancer != true){
     dynamic data = ModalRoute.of(context)!.settings.arguments ?? "";
     if(data != null){
       isServicemen = data;
     }
   }
    pendingBookingModel = PendingBookingModel.fromJson( isServicemen ? appArray.pendingBookingDetailWithList : appArray.pendingBookingDetailList);
    notifyListeners();
  }

  showBookingStatus(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return BookingStatusDialog();
        });
  }

  onRejectBooking(context) {
    showDialog(
        context: context,
        builder: (context1) => AppAlertDialogCommon(
          isField: true,
          validator: (value) => validation.commonValidation(context,value),
          focusNode: reasonFocus,
          controller: reasonCtrl,
          title: appFonts.reasonOfRejectBooking,
          singleText: appFonts.send,
          globalKey: formKey,
          singleTap: () {
            if(formKey.currentState!.validate()){
              route.pop(context);
              final data = Provider.of<DashboardProvider>(context, listen: false);
              data.selectIndex = 1;
              route.pushNamed(context, routeName.dashboard);
              data.notifyListeners();
            }
            notifyListeners();
          }
        ));
  }

  onAcceptBooking(context) {

    if(isFreelancer) {
      route.pushNamed(context, routeName.acceptedBooking);
    } else if(isServicemen == false) {
      amountCtrl.text = "";
      isAmount = false;
     notifyListeners();
     showModalBottomSheet(
          isScrollControlled: true,
         context: context, builder: (context) =>
        StatefulBuilder(
          builder: (context,setState) {
            return Consumer<PendingBookingProvider>(
              builder: (context,value,child) {
                return ServicemenChargesSheet(formKey: amountFormKey,controller: amountCtrl,focusNode: amountFocus,onTap: (){
                    if(amountFormKey.currentState!.validate()){
                      isAmount = true;
                      route.pop(context);
                      route.pushNamed(context, routeName.acceptedBooking, arg: {
                       "amount": amountCtrl.text
                      });
                      notifyListeners();
                    }
                  });
              }
            );
          }
        )
     );
    } else {
      isAmount = false;
      notifyListeners();
      showDialog(
          context: context,
          builder: (context1) =>
              AppAlertDialogCommon(
                  height: Sizes.s100,
                  title: appFonts.assignBooking,
                  firstBText: appFonts.doItLater,
                  secondBText: appFonts.yes,
                  image: eGifAssets.dateGif,
                  subtext: appFonts.doYouWant,
                  firstBTap: () => route.pop(context),
                  secondBTap: () {
                    route.pop(context);
                    route.pushNamed(context, routeName.acceptedBooking);
                  }
              ));
    }
  }
}
