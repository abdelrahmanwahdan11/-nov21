import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static const supportedLocales = [Locale('en'), Locale('ar')];

  static const _localizedStrings = {
    'en': {
      'app_title': 'Roamify',
      'home': 'Home',
      'search': 'Search',
      'ai': 'AI',
      'rewards': 'Rewards',
      'settings': 'Settings',
      'login': 'Login',
      'email': 'Email',
      'password': 'Password',
      'forgot_password': 'Forgot password?',
      'welcome': 'Plan your next stay',
      'book_now': 'Book now',
      'favorites': 'Favorites',
      'ai_info': 'AI info coming soon',
      'language': 'Language',
      'theme': 'Dark mode',
      'primary_color': 'Primary color',
    },
    'ar': {
      'app_title': 'روميفاي',
      'home': 'الرئيسية',
      'search': 'بحث',
      'ai': 'الذكاء الاصطناعي',
      'rewards': 'المكافآت',
      'settings': 'الإعدادات',
      'login': 'تسجيل الدخول',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'forgot_password': 'نسيت كلمة المرور؟',
      'welcome': 'خطط لإقامتك القادمة',
      'book_now': 'احجز الآن',
      'favorites': 'المفضلة',
      'ai_info': 'معلومات الذكاء الاصطناعي قريباً',
      'language': 'اللغة',
      'theme': 'الوضع الداكن',
      'primary_color': 'اللون الأساسي',
    },
  };

  String translate(String key) => _localizedStrings[locale.languageCode]?[key] ?? key;
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}
