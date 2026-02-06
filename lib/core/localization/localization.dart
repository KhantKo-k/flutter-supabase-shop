
import 'package:flutter/material.dart';
import 'package:shop_project/core/localization/l10n/app_localizations.dart';

extension LocalizationExtensions on BuildContext{
  AppLocalizations get tr => AppLocalizations.of(this);

  Locale get currentLocale => Localizations.localeOf(this);
  bool get isEnglish => currentLocale.languageCode == 'en';
  bool get isMyanmar => currentLocale.languageCode == 'my';
}

class LanguageManager with ChangeNotifier{
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale newLocale){
    _locale = newLocale;
    notifyListeners();
  }

  void toogleLanguage(){
    _locale = _locale.languageCode == 'en'
      ? const Locale('my')
      : const Locale('en');
    notifyListeners();
  }
}