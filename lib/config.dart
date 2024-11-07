import 'package:fixit_provider/widgets/common_fonts.dart';

import '../common/app_array.dart';
import '../common/app_fonts.dart';
import '../common/languages/app_language.dart';
import '../common/session.dart';
import '../helper/navigation_class.dart';
import 'config.dart';
export '../packages_list.dart';
export 'package:flutter/material.dart';
export '../routes/index.dart';
export '../common/assets/index.dart';
export '../providers/index.dart';
export '../common/extension/text_style_extensions.dart';
export '../widgets/common_state.dart';
export '../common/extension/spacing.dart';
export '../common/theme/app_css.dart';
export '../common/extension/widget_extension.dart';
export '../../routes/screen_list.dart';
export '../common/theme/theme_service.dart';
export '../widgets/button_common.dart';
export '../widgets/loading_component.dart';
export '../helper/validation.dart';
export '../widgets/fields_background.dart';
export '../widgets/small_container.dart';
export '../widgets/text_field_common.dart';
export '../widgets/common_arrow.dart';
export '../widgets/auth_app_bar_common.dart';
export '../utils/extensions.dart';
export '../widgets/auth_top_layouts.dart';
export '../widgets/container_with_text_layout.dart';
export '../widgets/alert_dialog_common.dart';
export '../widgets/app_bar_common.dart';
export '../widgets/dotted_line.dart';
export '../widgets/custom_painters.dart';
export '../widgets/service_available_layout.dart';
export '../widgets/drop_down_common.dart';
export '../widgets/divider_common.dart';
export '../utils/general_utils.dart';
export '../widgets/bottom_sheet_buttons_common.dart';
export '../../../../model/category_model.dart';
export '../widgets/flutter_switch_common.dart';
export '../widgets/heading_row_common.dart';
export '../widgets/empty_layout.dart';
export '../widgets/search_text_filed_common.dart';
export '../widgets/tab_bar_decoration.dart';
export '../widgets/filter_icon_common.dart';
export '../widgets/checkbox_common.dart';
export '../widgets/image_picker_layout.dart';
export '../widgets/description_layout.dart';
export '../widgets/known_language_layout.dart';
export '../widgets/upload_image_layout.dart';
export '../widgets/services_delivered_layout.dart';
export '../widgets/profile_pic_common.dart';
export '../../model/profile_model.dart';
export '../widgets/action_app_bar.dart';
export '../widgets/provider_details_layout.dart';
export '../widgets/star_layout.dart';
export '../widgets/status_layout_common.dart';
export '../widgets/arrow_right_common.dart';
export '../widgets/social_icon_common.dart';
export '../widgets/customer_details_layout.dart';
export '../widgets/review_bottom_layout.dart';
export '../model/subscription_plan_model.dart';
export '../widgets/booking_id_layout.dart';
export '../widgets/booking_status_layout.dart';
export '../widgets/common_filter_layout.dart';
export '../widgets/customer_service_layout.dart';
export '../widgets/view_location_common.dart';
export '../widgets/common_radio_button.dart';
export '../widgets/radio_button_common.dart';
export '../widgets/app_alert_dialog_common.dart';
export '../widgets/popup_item_row_common.dart';
export '../widgets/popup_menu_item_common.dart';
export '../widgets/bottom_sheet_top_layout.dart';
export '../widgets/more_option_layout.dart';
export '../services/user_services.dart';
export '../widgets/dark_drop_down_layout.dart';
export '../widgets/country_picker_custom/country_code_custom.dart';
export '../widgets/add_new_box_layout.dart';
export '../widgets/servicemen_charges_sheet.dart';
export '../widgets/servicemen_payable_layout.dart';
export '../widgets/contact_detail_row_common.dart';
export '../widgets/add_service_image_layout.dart';
export '../helper/alert_class.dart';



ThemeService appColor(context) {
  final themeServices = Provider.of<ThemeService>(context, listen: false);
  return themeServices;
}

CurrencyProvider currency(context) {
  final currencyData = Provider.of<CurrencyProvider>(context, listen: false);
  return currencyData;
}

getSymbol(context) {
  final currencyData =
      Provider.of<CurrencyProvider>(context, listen: true).priceSymbol;

  return currencyData;
}

showLoading(context) async {
  Provider.of<LoadingProvider>(context, listen: false).showLoading();
}

hideLoading(context) async {
  Provider.of<LoadingProvider>(context, listen: false).hideLoading();
}

String language(context, text) {
  return AppLocalizations.of(context)!.translate(text);
}

bool rtl(context){
  return AppLocalizations.of(context)?.locale.languageCode == "ar";
}




Session session = Session();
AppFonts appFonts = AppFonts();
NavigationClass route = NavigationClass();
AppArray appArray = AppArray();
Validation validation = Validation();
AppCss appCss = AppCss();
TextCommon textCommon = TextCommon();