import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'ar.dart';
import 'en.dart';
import 'es.dart';
import 'fr.dart';
import 'vi.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationDelagate();

  static AppLocalizations? of(context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);
  Future<bool> load() async {
    return true;
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': en,
    'fr': fr,
    'es': es,
    'ar': ar,
    'vi': vi
  };
  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class AppLocalizationDelagate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelagate();

  @override
  bool isSupported(Locale locale) {
    log("localelocale : $locale");
    return ['en', 'fr', 'es', 'ar', 'vi'].contains(locale.languageCode);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) {
    return false;
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appLocalizations = AppLocalizations(locale);
    await appLocalizations.load();
    return appLocalizations;
  }
}
