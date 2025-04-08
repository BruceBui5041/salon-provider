import 'dart:developer';
import 'package:salon_provider/common/languages/language_helper.dart';
import '../../config.dart';

class LanguageProvider with ChangeNotifier {
  String currentLanguage = appFonts.english;
  String selectLanguage = appFonts.english;
  Locale? locale;
  int selectedIndex = 0;
  final SharedPreferences sharedPreferences;

  LanguageProvider(this.sharedPreferences) {
    var selectedLocale = sharedPreferences.getString("selectedLocale");
    var listenIndex = sharedPreferences.getInt("index");
    if (listenIndex != null) {
      selectedIndex = listenIndex;
    } else {
      selectedIndex = 0;
    }
    log("fdhjgfthj : $selectedLocale");
    if (selectedLocale != null) {
      locale = Locale(selectedLocale);
    } else {
      selectedLocale = "english";
      locale = const Locale("en");
    }
    log("localelocalelocale :$locale");
    log("localelocalelocale1 :$selectedLocale");
    setVal(selectedLocale);
  }

  LanguageHelper languageHelper = LanguageHelper();

  onRadioChange(index, value) {
    selectedIndex = index;
    selectLanguage = value["title"];
    sharedPreferences.setInt("index", selectedIndex);
    log("SELECT LANGUAGE $selectLanguage");
    notifyListeners();
  }

  changeLocale(String newLocale) {
    log("sharedPreferences a1: $selectLanguage");
    Locale convertedLocale;

    currentLanguage = selectLanguage;
    log("CURRENT $currentLanguage");
    convertedLocale = languageHelper.convertLangNameToLocale(selectLanguage);

    log("convertedLocale $convertedLocale");

    locale = convertedLocale;
    log("CURRENT LOCAL ${locale!.languageCode.toString()}");
    sharedPreferences.setString(
        'selectedLocale', locale!.languageCode.toString());
    notifyListeners();
  }

  onBoardLanguageChange(String newLocale) {
    log("sharedPreferences a1: $newLocale");
    Locale convertedLocale;

    currentLanguage = newLocale;
    log("CURRENT $currentLanguage");
    convertedLocale = languageHelper.convertLangNameToLocale(newLocale);

    locale = convertedLocale;
    log("CURRENT LOCAL $locale");
    sharedPreferences.setString(
        'selectedLocale', locale!.languageCode.toString());
    notifyListeners();
  }

  getLocal() {
    var selectedLocale = sharedPreferences.getString("selectedLocale");
    return selectedLocale;
  }

  defineCurrentLanguage(context) {
    String? definedCurrentLanguage;

    if (currentLanguage.isNotEmpty) {
      definedCurrentLanguage = currentLanguage;
    } else {
      print(
          "locale from currentData: ${Localizations.localeOf(context).toString()}");
      definedCurrentLanguage = languageHelper
          .convertLocaleToLangName(Localizations.localeOf(context).toString());
    }

    return definedCurrentLanguage;
  }

  setVal(value) {
    if (value == "en") {
      currentLanguage = "english";
    } else if (value == "vi") {
      currentLanguage = "vietnamese";
    } else if (value == "fr") {
      currentLanguage = "french";
    } else if (value == "es") {
      currentLanguage = "spanish";
    } else if (value == "ar") {
      currentLanguage = "arabic";
    } else {
      currentLanguage = "english";
    }
    notifyListeners();
    // changeLocale(currentLanguage);
  }
}
