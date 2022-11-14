import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../router/navigator.dart';

class AppLocale {
  late Locale locale;

  AppLocale(this.locale);

  late Map<String, String> _loadedLocalizedValues;

  static AppLocale of(BuildContext context) {
    return Localizations.of(context, AppLocale);
  }

  Future loadLang() async {
    print(locale.languageCode);
    String _langFile = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> _loadedValues = jsonDecode(_langFile);
    _loadedLocalizedValues = _loadedValues.map((key, value) => MapEntry(key, value.toString()));
  }

  String getTranslated(String key) {
    return _loadedLocalizedValues[key]!;
  }

  static const LocalizationsDelegate<AppLocale> delegate = _AppLocalDelegate();
}

class _AppLocalDelegate extends LocalizationsDelegate<AppLocale> {
  const _AppLocalDelegate();
  @override
  bool isSupported(Locale locale) {
    return ["en", "ar"].contains(locale.languageCode);
  }

  @override
  Future<AppLocale> load(Locale locale) async {
    AppLocale appLocale = AppLocale(locale);
    await appLocale.loadLang();
    return appLocale;
  }

  @override
  bool shouldReload(_AppLocalDelegate old) => false;
}

String getLang(String key) {
  return AppLocale.of(CustomNavigator.navigatorState.currentContext!).getTranslated(key);
}

String currentLang()=>AppLocale.of(CustomNavigator.navigatorState.currentContext!).locale.languageCode;
